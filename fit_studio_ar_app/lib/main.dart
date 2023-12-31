import 'package:fit_studio_ar_app/constants/colors.dart';
import 'package:fit_studio_ar_app/routes/app.routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_studio_ar_app/components/cart_card.dart';
import 'package:fit_studio_ar_app/screens/cart_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: "AIzaSyAN0ax_JZJ4TyDM6fZMzRMfvAqgo0_faRA", 
    appId: "1:454046820275:android:3cb3954452ed394e72cdc6", 
    messagingSenderId: "454046820275", 
    projectId: "fitstudio-a439e",
    ),);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fit Studio',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: ThemeData(
            colorSchemeSeed: redColor,
            brightness: Brightness.light,
            textTheme:
            GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(
              bodyColor: blackColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 1,
                  textStyle: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  shape: const StadiumBorder()),
            )),
        darkTheme: ThemeData(
            colorSchemeSeed: redColor,
            brightness: Brightness.dark,
            textTheme:
            GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(
              bodyColor: blackColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 1,
                  textStyle: GoogleFonts.openSans(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  shape: const StadiumBorder()),
            )),
        initialRoute: AppRoutes.OnboardingRoute,
        routes: AppRoutes.routes,
    );
  }
}
