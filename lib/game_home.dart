import 'dart:async';
import 'package:flutter/material.dart';
import 'package:games/variables/local_variables.dart';
import 'package:games/variables/modal_variable.dart';
import 'package:games/widgets/commonboxnew.dart';
import 'package:games/widgets/commonmincoinbar.dart';
import 'package:games/widgets/commontop.dart';
import 'package:games/widgets/commonunlockbox.dart';
import 'package:games/widgets/help.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    getdeviceId();
    _startTimer();
    // updateCoins(deviceId, gameCoins.toString());
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      if (now.hour == 23 && now.minute == 59 && now.second == 59) {
        // Reset your data here
        _resetData();
      }
    });
  }

  void _resetData() async {
    // Perform your data reset task here
    var prefs = await SharedPreferences.getInstance();
    var tasklen = prefs.getInt(tasklenghtLabel)!;
    prefs.setBool("task ${tasklen - 1}", false);

    print('Resetting data at ${DateTime.now()}');
    // You can update state variables or call functions to reset data
  }

  Future<void> getdeviceId() async {
    var prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString(deviceIdLabel)!;
  }

  Future<bool> showOrNot() async {
    var prefs = await SharedPreferences.getInstance();
    var tasklen = prefs.getInt(tasklenghtLabel)!;
    var tasklenval = prefs.getBool("click ${tasklen - 1}");

    return tasklenval!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Commontop(),
                const SizedBox(
                  height: 16,
                ),
                CommonMinCoinBar(
                  text: otherLinksModel.otherlinks![7].link,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonBoxNew(
                      text: 'CLICKS',
                      route: '/premium',
                      fontSize: 30.0,
                    ),
                  ],
                ),
                if (objLive)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonUnlockBox(text: "Premium Task", fontSize: 25),
                    ],
                  ),
                FutureBuilder(
                  future: showOrNot(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.hasData && snapshot.data!) {
                        return const CommonUnlockBox(
                          text: "Get Code",
                          fontSize: 25,
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  // height: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        'Rules!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        otherLinksModel.otherlinks![9].link,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
