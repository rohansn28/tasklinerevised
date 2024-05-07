import 'dart:async';
import 'package:flutter/material.dart';
import 'package:games/variables/local_variables.dart';
import 'package:games/variables/modal_variable.dart';
import 'package:games/widgets/commonboxnew.dart';
import 'package:games/widgets/commonmincoinbar.dart';
import 'package:games/widgets/commontop.dart';
import 'package:games/widgets/commonunlockbox.dart';
import 'package:games/widgets/helpbox.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  String? devId;

  Future<void> getdeviceId() async {
    var prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString(deviceIdLabel)!;
    setState(() {
      devId = deviceId;
    });
  }

  Future<bool> showOrNot() async {
    var prefs = await SharedPreferences.getInstance();
    var tasklen = prefs.getInt(tasklenghtLabel)!;
    var tasklenval = prefs.getBool("task $tasklen");

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonBoxNew(
                      text: 'TASKS',
                      route: '/premium',
                      fontSize: 30.0,
                      deviceid: devId,
                      shareText: otherLinksModel.otherlinks![11].link,
                    ),
                    const NeedHelpBox(route: '/help'),
                  ],
                ),
                if (objLive)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonUnlockBox(
                        text: "PREMIUM GAMES",
                        fontSize: 25,
                      ),
                      // CommonUnlockBox(
                      //   text: "AD FREE GAMES",
                      //   fontSize: 28.0,
                      // ),
                    ],
                  ),
                FutureBuilder(
                  future: showOrNot(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.hasData && snapshot.data!) {
                        return CommonUnlockBox(
                          text: "Get Code",
                          fontSize: 25,
                          deviceid: devId,
                          shareText: otherLinksModel.otherlinks![11].link,
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
