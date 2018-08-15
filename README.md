# phone_state_i

#Listen to Phone Call State and provide call back

import 'package:phone_state_i/phone_state_i.dart';

phoneStateCallEvent.listen((PhoneStateCallEvent event) {
      print('Call is Incoming/Connected' + event.stateC);
      //event.stateC has values "true" or "false"
});




