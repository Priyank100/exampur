package com.edudrive.exampur

import android.Manifest
import android.annotation.SuppressLint
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import android.view.KeyEvent
import android.view.View
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.ImageView
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*
import android.widget.ProgressBar
import android.content.Context
import android.webkit.JavascriptInterface
import androidx.appcompat.app.AlertDialog


class WebViewActivity : FlutterActivity() {


    var webView: WebView? = null
    var backButton: ImageView? = null
    private val TAG = MainActivity::class.java.simpleName
    private var mCM: String? = null
    private var mUM: ValueCallback<Uri>? = null
    private val FCR = 1
    private var mUMA: ValueCallback<Array<Uri>>? = null
    var progress: ProgressBar? = null
    var doubtCourseId : String = "";



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_web_view)

        backButton = findViewById<View>(R.id.back) as ImageView
        progress = findViewById<View>(R.id.progress) as ProgressBar

        backButton!!.setOnClickListener {
            finish();
        }


        if (Build.VERSION.SDK_INT >= 23 && (ContextCompat.checkSelfPermission(
                        this,
                        Manifest.permission.WRITE_EXTERNAL_STORAGE
                ) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(
                        this,
                        Manifest.permission.CAMERA
                ) != PackageManager.PERMISSION_GRANTED)
        ) {
            ActivityCompat.requestPermissions(
                    this@WebViewActivity,
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.CAMERA),
                    1
            )
        }

        webView = findViewById<View>(R.id.webview) as WebView
        assert(webView != null)
        val webSettings = webView!!.settings
        webSettings.javaScriptEnabled = true
        webSettings.allowFileAccess = true

        doubtCourseId = getIntent().getStringExtra("url")!!.substring(getIntent().getStringExtra("url")!!.lastIndexOf('/') + 1);
        doubtCourseId = doubtCourseId.substringBefore("?")

        webView!!.getSettings().setDomStorageEnabled(true)
        webView!!.addJavascriptInterface(MyJavaScriptInterface(this@WebViewActivity), "ButtonRecognizer")

        if (Build.VERSION.SDK_INT >= 21) {
            webSettings.mixedContentMode = 0
            webView!!.setLayerType(View.LAYER_TYPE_HARDWARE, null)
        } else if (Build.VERSION.SDK_INT >= 19) {
            webView!!.setLayerType(View.LAYER_TYPE_HARDWARE, null)
        } else if (Build.VERSION.SDK_INT < 19) {
            webView!!.setLayerType(View.LAYER_TYPE_SOFTWARE, null)
        }
        webView!!.webViewClient = WebViewActivity.Callback()
        webView!!.loadUrl(""+ getIntent().getStringExtra("url"))

        webView!!.webChromeClient = object : WebChromeClient() {


            //For Android 5.0+
            override fun onShowFileChooser(
                    webView: WebView, filePathCallback: ValueCallback<Array<Uri>>,
                    fileChooserParams: FileChooserParams
            ): Boolean {


                if (mUMA != null) {
                    mUMA!!.onReceiveValue(null)
                }
                mUMA = filePathCallback
                var takePictureIntent: Intent? = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                if (takePictureIntent!!.resolveActivity(this@WebViewActivity.packageManager) != null) {
                    var photoFile: File? = null
                    try {
                        photoFile = createImageFile()
                        takePictureIntent.putExtra("PhotoPath", mCM)
                    } catch (ex: IOException) {
                        Log.e(TAG, "Image file creation failed", ex)
                    }
                    if (photoFile != null) {
                        mCM = "file:" + photoFile.absolutePath
                        takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(photoFile))
                    } else {
                        takePictureIntent = null
                    }
                }
                val contentSelectionIntent = Intent(Intent.ACTION_GET_CONTENT)
                contentSelectionIntent.addCategory(Intent.CATEGORY_OPENABLE)
                contentSelectionIntent.type = "*/*"
//                val intentArray: Array<Intent?>
//                intentArray = takePictureIntent?.let { arrayOf(it) } ?: arrayOfNulls(0)
//                val chooserIntent = Intent(Intent.ACTION_CHOOSER)
//                chooserIntent.putExtra(Intent.EXTRA_INTENT, contentSelectionIntent)
//                chooserIntent.putExtra(Intent.EXTRA_TITLE, "Image Chooser")
//                chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, intentArray)
//                startActivityForResult(chooserIntent, FCR)


                val i = Intent()
                i.type = "image/*"
                i.action = Intent.ACTION_GET_CONTENT
                startActivityForResult(Intent.createChooser(i, "Select Picture"), FCR)


                return true
            }
        }

        webView!!.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView, url: String) {
                super.onPageFinished(view, url)
                progress!!.visibility = View.GONE
                loadEvent(clickListener())
            }

            private fun loadEvent(javascript: String) {
                webView!!.loadUrl("javascript:$javascript")
            }

            private fun clickListener(): String {
                return """${buttons}
                    for(var i = 0; i < buttons.length; i++){
                        buttons[i].onclick = function(){
//                            console.log(">>>>>>>>>>>Anchal");
//                            console.log($(this).attr('id'));
//                            console.log(${doubtCourseId});
                            if(${doubtCourseId} == $(this).attr('id')) {
                                ButtonRecognizer.boundMethod('button clicked');
                            }
                        };
                    }"""
            }

            private val buttons: String
                private get() = "var buttons = document.getElementsByClassName('btn btn-primary');"

        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
        super.onActivityResult(requestCode, resultCode, intent)


        if (Build.VERSION.SDK_INT >= 21) {
//            var results: Array<Uri?>? = null
            //Check if response is positive
            if (resultCode == RESULT_OK) {
                if (requestCode == FCR) {
                    if (null == mUMA) {
                        return
                    }
                    if (intent == null) {
                        //Capture Photo if no image available
                        if (mCM != null) {
//                            results = arrayOf(Uri.parse(mCM))
                            Toast.makeText(this, "first part", Toast.LENGTH_SHORT).show()
                            mUMA!!.onReceiveValue(arrayOf(Uri.parse(mCM)))
                        }
                    } else {
                        val dataString = intent.dataString
                        if (dataString != null) {
//                            results = arrayOf(Uri.parse(dataString))
                            mUMA!!.onReceiveValue(arrayOf(Uri.parse(dataString)))
                        }
                    }
                }
            }
//            mUMA!!.onReceiveValue(results)
            mUMA = null


            if(resultCode == 0){
                mUMA = null
            }


        } else {

            if (requestCode == FCR) {
                if (null == mUM) return
                val result = if (intent == null || resultCode != RESULT_OK) null else intent.data
                mUM!!.onReceiveValue(result)
                mUM = null
            }
        }
    }


    class Callback : WebViewClient() {
        override fun onReceivedError(
                view: WebView,
                errorCode: Int,
                description: String,
                failingUrl: String
        ) {
//            Toast.makeText(this, "Failed loading app!", Toast.LENGTH_SHORT).show()
        }
    }

    // Create an image file
    @Throws(IOException::class)
    private fun createImageFile(): File? {
        @SuppressLint("SimpleDateFormat") val timeStamp =
                SimpleDateFormat("yyyyMMdd_HHmmss").format(
                        Date()
                )
        val imageFileName = "img_" + timeStamp + "_"
        val storageDir =
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
        return File.createTempFile(imageFileName, ".jpg", storageDir)
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        if (event.action == KeyEvent.ACTION_DOWN) {
            when (keyCode) {
                KeyEvent.KEYCODE_BACK -> {
                    if (webView!!.canGoBack()) {
                        webView!!.goBack()
                    } else {
                        finish()
                    }
                    return true
                }
            }
        }
        return super.onKeyDown(keyCode, event)
    }


//    fun onConfigurationChanged(newConfig: Configuration?) {
//        super.onConfigurationChanged(newConfig!!)
//    }


    inner class MyJavaScriptInterface(ctx: Context) {
        @JavascriptInterface
        fun boundMethod(html: String?) {
            val intent = Intent()
            intent.putExtra("Submitted", "Done")
            setResult(1, intent)
            finish()
        }
    }

}