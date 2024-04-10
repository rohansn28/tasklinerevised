import 'package:flutter/material.dart';
import 'package:games/utils/web.dart';
import 'package:games/variables/local_variables.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void initPrefs(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(gameCoinsLabel)) {
    gameCoins = prefs.getInt(gameCoinsLabel)!;
    deviceId = prefs.getString(deviceIdLabel)!;
  } else {
    prefs.setString(deviceIdLabel, const Uuid().v4());
    deviceId = prefs.getString(deviceIdLabel)!;

    prefs.setInt(gameCoinsLabel, 0);
    gameCoins = 0;
    prefs.setBool(isActiveLabel, false);
    sendDeviceIdToBackend(deviceId, gameCoins.toString());
  }
  Navigator.popAndPushNamed(context, "/gamehome");
}

Future<int> increaseGameCoin(int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(gameCoinsLabel, prefs.getInt(gameCoinsLabel)! + value);
  gameCoins = prefs.getInt(gameCoinsLabel)!;

  return gameCoins;
}
