package com.edudrive.exampur

import com.moengage.core.LogLevel;
import com.moengage.core.MoEngage;
import com.moengage.core.MoEngage.Builder;
import com.moengage.core.config.FcmConfig;
import com.moengage.core.config.LogConfig;
import com.moengage.core.config.MiPushConfig;
import com.moengage.core.config.PushKitConfig;
import com.moengage.core.config.NotificationConfig;
import com.moengage.flutter.MoEInitializer;
import com.moengage.pushbase.MoEPushHelper;
import io.flutter.app.FlutterApplication;
import com.moengage.core.DataCenter

class SampleApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        val moEngage = MoEngage.Builder(this, "UAIIRLJXLAVMA3I6TOFYHV8P")
            .setDataCenter(DataCenter.DATA_CENTER_3)
            .configureNotificationMetaData(NotificationConfig(R.drawable.logo, R.drawable.logo))
            .configureLogs(LogConfig(LogLevel.VERBOSE, true));
        MoEInitializer.initialize(this, moEngage);

    }
}