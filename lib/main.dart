import 'package:flutter/material.dart';
import 'package:games/game_home.dart';
import 'package:games/help_screen.dart';
import 'package:games/premium_screen.dart';
import 'package:games/resumetracking_screen.dart';
import 'package:games/startpage.dart';
import 'package:games/utils/web.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:kochava_tracker/kochava_tracker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initKochava();
  initOneSignal();
  String check = await fetchButtonLinks('buttonlinks');
  if (check != "0") {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskLine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 98, 42, 71),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      routes: {
        "/gamehome": (context) => const GameHome(),
        "/": (context) => const StartPg(),
        "/startpg": (context) => const StartPg(),
        "/premium": (context) => const PremiumScreen(),
        "/help": (context) => const HelpScreen(),
        "/tracking": (context) => const ResumeTrackingScreen(),
      },
    );
  }
}

void initOneSignal() {
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("0aee07dd-fa8b-4d72-b419-b951aa223c76");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
}

void initKochava() {
  KochavaTracker.instance.registerAndroidAppGuid("kotaskline-ws9dx");
  // KochavaTracker.instance.registerIosAppGuid("YOUR_IOS_APP_GUID");
  KochavaTracker.instance.start();
}
