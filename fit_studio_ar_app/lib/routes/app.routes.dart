// ignore_for_file: constant_identifier_names

import 'package:fit_studio_ar_app/screens/forgot_password_screen.dart';
import 'package:fit_studio_ar_app/screens/homepage.dart';
import 'package:fit_studio_ar_app/screens/onboarding_screen.dart';
import 'package:fit_studio_ar_app/screens/sign_up_screen.dart';
import 'package:fit_studio_ar_app/screens/cart_page.dart';
import 'package:fit_studio_ar_app/screens/payment_page.dart';

import '../screens/login_screen.dart';

class AppRoutes {
  static const String LoginRoute = "/login";
  static const String OnboardingRoute = "/onboarding";
  static const String SignUpRoute = "/signup";
  static const String HomeRoute = "/home";
  static const String PreviewRoute = "/preview";
  static const String ForgotPasswordRoute = "/forgotpassword";
  static const String CartRoute ="/cart";
  static const String PaymentRoute="/payment";

  static final routes = {
    OnboardingRoute: (context) => const OnboardingScreen(),
    LoginRoute: (context) => const LoginScreen(),
    SignUpRoute: (context) => const SignUpScreen(),
    HomeRoute: (context) => const HomePageScreen(),
    ForgotPasswordRoute: (context) => const ForgotPasswordScreen(),
    CartRoute: (context) => const CartPage(),
    PaymentRoute:(context) => PaymentPage(),
  };
}
