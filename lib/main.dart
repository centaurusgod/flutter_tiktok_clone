import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

MaterialColor customColor = const MaterialColor(0x00000000, {
  50: Colors.transparent,
  100: Colors.transparent,
  200: Colors.transparent,
  300: Colors.transparent,
  400: Colors.transparent,
  500: Colors.transparent,
  600: Colors.transparent,
  700: Colors.transparent,
  800: Colors.transparent,
  900: Colors.transparent,
});
void main() {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MaterialApp(
    title: "FLutter CLone",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData(
      primarySwatch: customColor,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

//the following code is to create a splash screen

class MyAppState extends State<MyApp> {
  double getDeviceScreenHeight = 0;
  double getDeviceScreenWidth = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    {
      final size = MediaQuery.of(context).size;
      getDeviceScreenHeight = size.height;
      getDeviceScreenWidth = size.width;
      log(getDeviceScreenHeight.toString());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: getDeviceScreenHeight,
        width: getDeviceScreenWidth,
        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(),
              SizedBox(
                height: getDeviceScreenHeight/4,
              ),
              Image.asset('assets/images/tiktok_lite_icon.png',
              width: getDeviceScreenWidth/4.74,
              height: getDeviceScreenHeight/8,
             // width: 100,
             // height: 100,
              ),
             // CircularProgressIndicator(),
              Text('TikTok',
               style: TextStyle(color: Colors.white,
        fontSize: 35.0,
         height: 1.0,
        fontFamily: 'ProximaNova',
        fontWeight:  FontWeight.w800,
        ),
        ),
         Text('Lite',
               style: TextStyle(color: Colors.white,
        fontSize: 25.0,
       
        fontFamily: 'ProximaNova',
        fontWeight: FontWeight.w700,
        ),
        ),
        CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
