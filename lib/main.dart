import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet/utils/theme/theme.dart';
import 'data/repositories/authentication_repository.dart';
import 'features/payment/consts.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {

  // Widgets
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();


  // Local Storage
  await GetStorage.init();

  // Loader as Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then(
        (FirebaseApp value) =>  Get.put(AuthenticationRepository()),
  );

  // Stripe
  Stripe.publishableKey = stripePublishableKey;
  // Initialize Flutter Local Notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      // Loader
      home: const Scaffold(backgroundColor: Colors.white, body: Center(child: CircularProgressIndicator(color: Colors.white,)))
    );
  }
}

//petcarecompanionspcc@gmail.com
//petcarecompanions
