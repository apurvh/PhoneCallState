package dexiumtech.phonestatei;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;

//import android.os.Bundle;
//import android.os.Environment;
//import static android.Manifest.permission.READ_PHONE_STATE;
import android.content.Context;


/** PhoneState_iPlugin */
public class PhoneState_iPlugin implements EventChannel.StreamHandler {

    private static final String PHONE_STATE =
            "PHONE_STATE_99";


    /** Plugin registration. */
    public static void registerWith(Registrar registrar) {

        final EventChannel phoneStateCallChannel =
                new EventChannel(registrar.messenger(), PHONE_STATE);
        phoneStateCallChannel.setStreamHandler(
                new PhoneState_iPlugin(registrar.context()));

    }

    private PhoneStateListener mPhoneListener;
    private final TelephonyManager telephonyManager;

    /** flag used for state */
    public static Boolean phoneCallOn=false;


    /** telephone manager */
    private PhoneState_iPlugin(Context context) {
        telephonyManager = (TelephonyManager) context.getSystemService(context.TELEPHONY_SERVICE);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        mPhoneListener = createPhoneStateListener(events);
        telephonyManager.listen(mPhoneListener, PhoneStateListener.LISTEN_CALL_STATE);
    }

    @Override
    public void onCancel(Object arguments) {
        ///
    }

    PhoneStateListener createPhoneStateListener(final EventChannel.EventSink events){
        return new PhoneStateListener(){
            @Override
            public void onCallStateChanged (int state, String phoneNumber){

                switch (state) {
                    case TelephonyManager.CALL_STATE_IDLE:
                        phoneCallOn = false;
                        break;
                    case TelephonyManager.CALL_STATE_OFFHOOK:
                        phoneCallOn = true;
                        break;
                    case TelephonyManager.CALL_STATE_RINGING:
                        phoneCallOn = true;
                        break;
                }
                events.success(phoneCallOn.toString());
            }
        };
    }

}
