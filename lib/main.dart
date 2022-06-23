import 'package:flutter/material.dart';
import 'package:shop/moudules/login_screen/login_screen.dart';
import 'package:shop/moudules/shop_layout_screen.dart';
import 'package:shop/network/cashe_helper.dart';
import 'package:shop/onBording_screen/onBording_Screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'network/dio_hepler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.init();

  Widget widget;

  Object? onBoarding = CasheHelper.getData(key: 'onBoarding');
  Object? tokeen = CasheHelper.getData(key: 'token');
  print(tokeen);

  if (onBoarding != null) {
    if (tokeen != null)
      widget = ShopLayoutScreen();
    else
      widget = LoginScreen();
  } else
    widget = OnBoarding_Screen();

  // print(onBoarding);
  //runApp(MyApp());
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  late Widget? startWidget;

  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: HexColor('6c63ff'),
          // primaryColor: ,
          brightness: Brightness.light,
          //    scaffoldBackgroundColor: Color(0xffffeed1),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 30,
            ),
            backgroundColor: Color(0xFFce8b75),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),
            //centerTitle: true,
            elevation: 5,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            //  selectedFontSize: 17,
            type: BottomNavigationBarType.fixed,
            //unselectedFontSize: 14,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.black,
            //  backgroundColor: Color(0xFFce8b75),
            elevation: 200,
          ),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600))),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          //scaffoldBackgroundColor: Color(0xff242B2E),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 30,
            ),
            //   backgroundColor: Colors.black87,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 30, color: Colors.white),
            centerTitle: true,
            elevation: 5,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            //  selectedFontSize: 17,
            type: BottomNavigationBarType.fixed,
            //unselectedFontSize: 14,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            //   backgroundColor: Colors.black87,
            elevation: 200,
          ),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w900))),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: startWidget,
      // home: onBoarding != null ? LoginScreen() : OnBoarding_Screen()
    );
    // home: OnBoarding_Screen());
  }
}
