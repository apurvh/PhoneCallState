#import "PhoneState_iPlugin.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@implementation PhoneState_iPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {


  FLTPhoneCallStateStreamHandler* phoneCallStateStreamHandler =
        [[FLTPhoneCallStateStreamHandler alloc] init];
  FlutterEventChannel* phoneCallStateChannel =
        [FlutterEventChannel eventChannelWithName:@"PHONE_STATE_99"
                                  binaryMessenger:[registrar messenger]];
  [phoneCallStateChannel setStreamHandler:phoneCallStateStreamHandler];


}

@end


CTCallCenter* _callManager;
NSMutableString *myTrue = nil;
NSMutableString *myFalse = nil;


void _initCallManager() {
  if (!_callManager) {
    _callManager = [[CTCallCenter alloc] init];
  }
}


@implementation FLTPhoneCallStateStreamHandler

+ (void)initialize {
    myFalse = [NSMutableString stringWithFormat:@"false"];
    myTrue = [NSMutableString stringWithFormat:@"true"];
}

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {

    _initCallManager();
    _callManager.callEventHandler = ^(CTCall* call){
        if (call.callState == CTCallStateDisconnected)
        {
            NSLog(@"Call has been disconnected");
            eventSink(myFalse);
        }
        else if (call.callState == CTCallStateConnected)
        {
            NSLog(@"Call has just been connected");
            eventSink(myTrue);
        }
        else if(call.callState == CTCallStateIncoming)
        {
            NSLog(@"Call is incoming");
            eventSink(myTrue);
        }
        else
        {
            NSLog(@"None of the conditions");

        }
    };

    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    return nil;
}

@end
