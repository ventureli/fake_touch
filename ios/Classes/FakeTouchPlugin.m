#import "FakeTouchPlugin.h"
#import "UITouch+Private.h"
#import "UIEvent+Private.h"

@implementation FakeTouchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"fake_touch"
            binaryMessenger:[registrar messenger]];
  FakeTouchPlugin* instance = [[FakeTouchPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"fake_native_tap" isEqualToString:call.method]) {
      
      NSDictionary *dict =  call.arguments;
      NSInteger x = [dict[@"x"] integerValue];
      NSInteger y = [dict[@"y"] integerValue];
      double duration = [dict[@"duration"] doubleValue];
      if(duration < 0.1)
      {
          duration = 0.1;
      }
      CGPoint point = CGPointMake(x, y);
      
      UIWindow *window = [[UIApplication sharedApplication] delegate].window;
      UITouch *touch = [[UITouch alloc] initWithLocation:point window:window];
      [touch setPhase:UITouchPhaseBegan];
      [UIEvent send:@[touch]];
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [touch udpateTimestamp];
          [touch setPhase:UITouchPhaseEnded];
          [UIEvent send:@[touch]];
      });
      result(@"1");
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
