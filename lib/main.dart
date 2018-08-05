import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

// App root class
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Platform-Specific',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = const MethodChannel('com.heikkidev.flutterplatformspecific/nativeservices');

  @override
  void initState() {
    super.initState();
    // Inicializacion de la página
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Platform-Specific"),
        ),
        body: getBody());
  }

  getBody() {
    return new Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
            colors: [
              Colors.blue[400],
              Colors.purpleAccent[100],
            ]
        )
      ),
      child: new GridView.count(
        crossAxisCount: 1,
        scrollDirection: Axis.vertical,
        childAspectRatio: 1.5,
        children: <Widget>[
          new Container(
              margin: new EdgeInsets.all(1.0),
              child: new Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    child: const Text('Abrir App Email'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      openDefaultMailApp();
                    },
                  ),
                ),
              )
          ),
          new Container(
              margin: new EdgeInsets.all(1.0),
              child: new Center(
                child: ButtonTheme(
                  minWidth: 300.0,
                  height: 55.0,
                  child: RaisedButton(
                    child: const Text(
                      'Abrir Ajustes',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    color: Colors.white,
                    elevation: 0.0,
                    splashColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      openSystemSettings();
                    },
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  openSystemSettings()async {
    try {
      final bool result = await platform.invokeMethod('openSystemSettings');
      if(result != true){
        //TODO: Mostrar toast de error o algo
      }
    }
    on PlatformException catch (e) {
      print("Error en openSystemSettings: " + e.message);
    }
  }

  openDefaultMailApp(){

  }

}
