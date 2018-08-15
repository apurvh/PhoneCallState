import 'dart:async';
import 'package:flutter/services.dart';



const EventChannel _phoneStateCallEventChannel =
EventChannel('PHONE_STATE_99');



class PhoneStateCallEvent{

  final String stateC;
  PhoneStateCallEvent(this.stateC);

  @override
  String toString() => '$stateC';
}



Stream<PhoneStateCallEvent> _phoneStateCallEvent;

PhoneStateCallEvent _listphoneStateCallEvent(String stateD){
  return new PhoneStateCallEvent(stateD);
}


/// A broadcast stream of events from the phone state.
Stream<PhoneStateCallEvent> get phoneStateCallEvent {
  if (_phoneStateCallEvent == null) {
    _phoneStateCallEvent = _phoneStateCallEventChannel
        .receiveBroadcastStream()
        .map(
            (dynamic event) => _listphoneStateCallEvent(event));
  }
  return _phoneStateCallEvent;
}
