import 'package:flutter/material.dart';
import 'package:games/controllers/launchpopup_screen.dart';
import 'package:games/controllers/local_store.dart';
import 'package:games/utils/chrome_custom_tabs.dart';
import 'package:games/widgets/popup.dart';
import 'package:games/widgets/time_remaining_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeTrackingScreen extends StatefulWidget {
  const ResumeTrackingScreen({super.key});

  @override
  State<ResumeTrackingScreen> createState() => _ResumeTrackingScreenState();
}

class _ResumeTrackingScreenState extends State<ResumeTrackingScreen>
    with WidgetsBindingObserver {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String seconds = "";
  String type = "";
  String id = "";
  String tasknamenew = "";
  String index = "";
  String len = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void setPrefs(
      String link, String coin, String seconds, String type, String id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("currentLink", link);
    prefs.setString(
        link,
        DateTime.now()
            .add(Duration(seconds: int.parse(seconds)))
            .toUtc()
            .toString());
    prefs.setString("coin", coin);
    prefs.setString("type", type);
    prefs.setString("id", id);
  }

  void checkPrefs() async {
    final SharedPreferences prefs = await _prefs;

    if (DateTime.parse(prefs.getString(prefs.getString("currentLink")!)!)
        .toUtc()
        .isAfter(DateTime.now().toUtc())) {
      // before time
      int timeLeft =
          DateTime.parse(prefs.getString(prefs.getString("currentLink")!)!)
              .difference(DateTime.now().toUtc())
              .inSeconds;
      timeRemainingHandle(timeLeft.toString(), prefs.getString("coin")!,
          prefs.getString("currentLink")!, index);
    } else {
      // after time

      winnerHandle(int.parse(prefs.getString("coin")!), tasknamenew, index);
    }
  }

  void winnerHandle(int coin, String tasnamenew, String index) {
    Navigator.pop(context);
    increaseGameCoin(coin);
    // showSnackBar(context, "You Won 100 Coins");
    launchPopupScreen(
      context,
      PopUp(
        coins: coin,
        taskname: tasknamenew,
        taskindex: index,
        tasklen: len,
      ),
    );
  }

  void timeRemainingHandle(
      String timeLeftSeconds, String coin, String link, String index) {
    Navigator.pop(context);
    // showSnackBar(context, "Please Wait 1 min on the website");
    launchPopupScreen(
        context,
        TimeRemainingWidget(
          seconds: timeLeftSeconds,
          coins: coin,
          link: link,
          type: type,
          id: id,
          taskname: tasknamenew,
          index: index,
          tasklen: len,
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool buildorNot = true;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      checkPrefs();
      setState(() {
        buildorNot = false;
      });
    }
  }

  void _launchLink(
      String link, String coin, String seconds, String type, String id) {
    setPrefs(link, coin, seconds, type, id);

    launchCustomTabURL(context, link);
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final link = routes['link'];
    final coin = routes['coin'];
    seconds = routes['seconds']!;
    type = routes['type']!;
    id = routes['id']!;

    setState(() {
      tasknamenew = routes['taskname']!;
      len = routes['tasklen']!;
      index = routes['index']!;
    });

    (link!);

    if (buildorNot) {
      _launchLink(
        link,
        coin!,
        seconds,
        type,
        id,
      );
    }
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: const Center(
          child: Text(
        "Please Wait...\n AD Loading...",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
