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
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*

class WebViewActivity : FlutterActivity() {


    var webView: WebView? = null
    private val TAG = MainActivity::class.java.simpleName
    private var mCM: String? = null
    private var mUM: ValueCallback<Uri>? = null
    private val FCR = 1
    private var mUMA: ValueCallback<Array<Uri>>? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_web_view)

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

        if (Build.VERSION.SDK_INT >= 21) {
            webSettings.mixedContentMode = 0
            webView!!.setLayerType(View.LAYER_TYPE_HARDWARE, null)
        } else if (Build.VERSION.SDK_INT >= 19) {
            webView!!.setLayerType(View.LAYER_TYPE_HARDWARE, null)
        } else if (Build.VERSION.SDK_INT < 19) {
            webView!!.setLayerType(View.LAYER_TYPE_SOFTWARE, null)
        }
        webView!!.webViewClient = WebViewActivity.Callback()
//        webView!!.webViewClient = com.example.webviewpoc.MainActivity.Callback()
//        webView!!.loadUrl("https://exampur.com/e-app/login?token=PVBcYoyoiChph5631666078922D46oLsGIkfnzMvW8&path=/e-app/doubt-session/2/")
        Toast.makeText(this, "loading  : "+ getIntent().getStringExtra("url"), Toast.LENGTH_SHORT).show();
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
                val intentArray: Array<Intent?>
                intentArray = takePictureIntent?.let { arrayOf(it) } ?: arrayOfNulls(0)
                val chooserIntent = Intent(Intent.ACTION_CHOOSER)
                chooserIntent.putExtra(Intent.EXTRA_INTENT, contentSelectionIntent)
                chooserIntent.putExtra(Intent.EXTRA_TITLE, "Image Chooser")
                chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, intentArray)
                startActivityForResult(chooserIntent, FCR)
                return true
            }
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
        super.onActivityResult(requestCode, resultCode, intent)
        if (Build.VERSION.SDK_INT >= 21) {
//            var results: Array<Uri?>? = null
            //Check if response is positive
            if (resultCode == RESULT_OK) {
                Toast.makeText(this, "Getting result ok ",Toast.LENGTH_SHORT).show()
                if (requestCode == FCR) {
                    if (null == mUMA) {
                        return
                    }
                    if (intent == null) {
                        //Capture Photo if no image available
                        if (mCM != null) {
//                            results = arrayOf(Uri.parse(mCM))
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
        } else {
            Toast.makeText(this, "Getting result is not ok ",Toast.LENGTH_SHORT).show()
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

}