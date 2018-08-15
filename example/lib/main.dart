
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phone_state_i/phone_state_i.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sensors Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamSubscription streamSubscription;

  @override
  Widget build(BuildContext context) {

    print('setstate');
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Example'),
      ),
      body: new Padding(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('A:'),
            new FlatButton(
                onPressed: () {
                  setState(() {
                    print('refresh');
                  });
                },
                child: Text('Refresh'))
          ],
        ),
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();

  }

  @override
  void initState() {
    super.initState();
    streamSubscription = phoneStateCallEvent.listen((PhoneStateCallEvent event) {
      print('Call is Incoming or Connected' + event.stateC);
      //event.stateC has values "true" or "false"
    });
  }
}
