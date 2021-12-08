package com.tencent.fake_touch;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Handler;
import android.os.SystemClock;
import android.util.Log;
import android.view.MotionEvent;
import android.view.ViewGroup;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FakeTouchPlugin */
public class FakeTouchPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  public static Context context;
  public static Activity activity;

  public static  FlutterApplication application;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fake_touch");
    channel.setMethodCallHandler(this);
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "hello_plugin");
    context = registrar.activeContext();
    activity = registrar.activity();
    FakeTouchPlugin plugin = new FakeTouchPlugin();
    channel.setMethodCallHandler(plugin);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {

    getApplication();

    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if (call.method.equals("fake_native_tap")) {

      if(call.arguments instanceof Map){
        float x = Float.parseFloat(((Map)call.arguments).get("x").toString());
        float y = Float.parseFloat(((Map)call.arguments).get("y").toString());
        float time = Float.parseFloat(((Map)call.arguments).get("time").toString());
        final long downTime = SystemClock.uptimeMillis();

        final MotionEvent downEvent = MotionEvent.obtain(
                downTime, downTime, MotionEvent.ACTION_DOWN, x, y, 0);
        final ViewGroup root = getRoowViewGroup();
        root.dispatchTouchEvent(downEvent);
        Log.e("FakeTouchPlugin","sender down event");
        final MotionEvent upEvent = MotionEvent.obtain(
                downTime, SystemClock.uptimeMillis(), MotionEvent.ACTION_UP, x, y, 0);
        new Handler().postDelayed(new Runnable() {
          @Override
          public void run() {
            root.dispatchTouchEvent(upEvent);
            Log.e("FakeTouchPlugin","sender up event");
            downEvent.recycle();
            upEvent.recycle();
            result.success("Android " + android.os.Build.VERSION.RELEASE);
          }
        }, (long) (time * 1000));
      }
    } else {
      result.notImplemented();
    }
  }

  private void getApplication() {
    if(application == null)
    {
      try {
        Application tmpApplication = (Application) Class.forName("android.app.ActivityThread").getMethod("currentApplication").invoke(null, (Object[]) null);
        if(tmpApplication instanceof FlutterApplication)
        {
          application = (FlutterApplication) tmpApplication;
        }
      }
      catch (Exception e) {
        e.printStackTrace();
      }


    }
  }

  ViewGroup getRoowViewGroup(){
    try{
      Activity theActivity = activity;
      if(application != null && application.getCurrentActivity() != null)
      {
        theActivity = application.getCurrentActivity();
      }
      if(theActivity != null)
      {
        final ViewGroup viewGroup = (ViewGroup) ((ViewGroup) activity
                .findViewById(android.R.id.content)).getChildAt(0);
        return viewGroup;
      }
      return null;
    }catch (Exception e)
    {
      e.printStackTrace();
    }
    return null;
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
