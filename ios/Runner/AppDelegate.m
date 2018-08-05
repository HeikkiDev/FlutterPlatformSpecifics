#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>

@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* flutterChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"com.heikkidev.flutterplatformspecific/nativeservices"
                                            binaryMessenger:controller];
    
    [flutterChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"openSystemSettings" isEqualToString:call.method]) {
            bool opneOk = [self openSystemSettings];
            
            if (opneOk == false) {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"Cannot open system settings."
                                           details:nil]);
            } else {
                result(@(opneOk));
            }
        }
        else if ([@"openDefaultMailApp" isEqualToString:call.method]) {
            bool opneOk = [self openDefaultMailApp];
            
            if (opneOk == false) {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                           message:@"Cannot open mail app."
                                           details:nil]);
            } else {
                result(@(opneOk));
            }
        }
        else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (bool)openSystemSettings {
    @try {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        return true;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        return false;
    }
}

- (bool)openDefaultMailApp {
    @try {
        NSURL* mailURL = [NSURL URLWithString:@"message://"];
        if ([[UIApplication sharedApplication] canOpenURL:mailURL]) {
            [[UIApplication sharedApplication] openURL:mailURL];
            return true;
        }
        else{
            return false;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        return false;
    }
}

@end
