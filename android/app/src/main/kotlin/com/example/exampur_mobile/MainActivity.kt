package com.edudrive.exampur

import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private lateinit var mResult: MethodChannel.Result


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter.native/helper").setMethodCallHandler {
            call, result ->
            mResult = result
            val intent = Intent(this, WebViewActivity::class.java)
            intent.putExtra("url", ""+call.method)
            startActivityForResult(intent, 123)
        }
    }



    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
        super.onActivityResult(requestCode, resultCode, intent)
        if (resultCode == 1) {
            if (requestCode == 123) {
                var res = intent!!.getStringExtra("Submitted")
                if (res.equals("Done")) {
                    mResult.success(res);
                }
            }
        }
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
    }
}
