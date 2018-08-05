package com.heikkidev.flutterplatformspecific;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.heikkidev.flutterplatformspecific/nativeservices";

  @Override
  public void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                if (call.method.equals("openSystemSettings")) {
                  boolean openOk = openSystemSettings();

                  if (openOk) {
                    result.success(openOk);
                  } else {
                    result.error("UNAVAILABLE", "Cannot open system settings.", null);
                  }
                }
                else if (call.method.equals("openDefaultMailApp")) {
                  boolean openOk = openDefaultMailApp();

                  if (openOk) {
                    result.success(openOk);
                  } else {
                    result.error("UNAVAILABLE", "Cannot open mail app.", null);
                  }
                }
                else {
                  result.notImplemented();
                }
              }
            });
  }

  private boolean openSystemSettings() {
    try {
      startActivityForResult(new Intent(android.provider.Settings.ACTION_SETTINGS), 0);
      return true;
    }
    catch (Exception ex){
      return false;
    }
  }

  private boolean openDefaultMailApp() {
    try {
      Intent intent = new Intent(Intent.ACTION_MAIN);
      intent.addCategory(Intent.CATEGORY_APP_EMAIL);
      startActivity(intent);
      return true;
    }
    catch (Exception ex){
      return false;
    }
  }

}
