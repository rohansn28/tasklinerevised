import 'package:flutter/material.dart';
import 'package:games/premium_screen.dart';
import 'package:games/utils/web.dart';
import 'package:games/variables/local_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopUp extends StatefulWidget {
  final int coins;
  final String taskindex;
  final String tasklen;

  final String taskname;
  const PopUp({
    super.key,
    required this.coins,
    required this.taskname,
    required this.taskindex,
    required this.tasklen,
  });

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  late SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    // print(widget.taskname);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      "Congratulations!!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      "You Won ${widget.coins} Coins",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0),
                    child: InkWell(
                      onTap: () async {
                        _prefs = await SharedPreferences.getInstance();

                        _prefs.setInt(widget.taskname,
                            DateTime.now().millisecondsSinceEpoch);

                        _prefs.setBool('click ${widget.taskindex}', true);

                        if (_prefs.getBool(
                                'click ${int.parse(widget.tasklen) - 1}') ==
                            true) {
                          _prefs.setBool(isActiveLabel, true);
                        }

                        Navigator.pop(context);

                        if (widget.taskname.contains('CLICK')) {
                          deviceId = _prefs.getString(deviceIdLabel)!;
                          updateCoins(deviceId, gameCoins.toString());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PremiumScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
