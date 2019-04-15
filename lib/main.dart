import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage.dart';




void main() => runApp(new MyApp());

class MyApp extends StatefulWidget{
  @override
  State createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Load the last saved value using SharedPreferences
  Brightness brightness=Brightness.light;
  _MyAppState(){
    loadSavedBrightnessValue();
  }

  //Fetches the last saved value of brightness and returns it
  loadSavedBrightnessValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      brightness=(prefs.getBool("isLight") ?? true) ? Brightness.light: Brightness.dark;
      if (brightness==Brightness.light){
        brightness=Brightness.light;
        clrAppBar=Color.fromARGB(250, 250, 250, 250);
        clrAppBarText=Colors.black12;
      } else {
        clrAppBar=Color.fromARGB(250, 46, 46, 46);
        clrAppBarText=Colors.white;
      }
    });
    return (prefs.getBool("isLight"));
  }
  //Saves the prefrence
  saveBrightnessValue(bool blValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLight", blValue);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calculator',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: brightness,
      ),
      home: new HomePage((){
        setState(() {
          if (brightness==Brightness.light){
            brightness=Brightness.dark;
            clrAppBar=Color.fromARGB(250, 46, 46, 46);
            clrAppBarText=Colors.white;
            saveBrightnessValue(true);
            Fluttertoast.showToast(
                msg: "Switched to dark theme!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );
          } else {
            brightness=Brightness.light;
            clrAppBar=Color.fromARGB(250, 250, 250, 250);
            clrAppBarText=Colors.black;
            saveBrightnessValue(false);
            Fluttertoast.showToast(
                msg: "Switched to light theme!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        });
      })
      );
  }




}








