import 'package:flutter/material.dart';
import 'package:games/variables/local_variables.dart';
import 'package:games/widgets/commonadmarkbottom.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CommonPremiumTask extends StatefulWidget {
  final String btnText;
  final String stayTime;
  final String winCoin;
  final String url;
  final int index;
  final Color color;
  String tasklen;
  // final Function(bool) onIsActiveChanged;

  CommonPremiumTask({
    super.key,
    required this.btnText,
    required this.stayTime,
    required this.winCoin,
    required this.url,
    required this.index,
    required this.color,
    required this.tasklen,
    // required this.onIsActiveChanged,
  });

  @override
  State<CommonPremiumTask> createState() => _CommonPremiumTaskState();
}

class _CommonPremiumTaskState extends State<CommonPremiumTask> {
  late SharedPreferences _prefs;
  late DateTime _lastCompletion;
  bool isActive = false;
  late final tasklength;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    if (gameCoins == 0) {
      _prefs.setBool('task ${widget.index}', false);
    }
    if (widget.index == 0) {
      _prefs.setInt(tasklenghtLabel, int.parse(widget.tasklen));
    }
    tasklength = _prefs.getInt(tasklenghtLabel);
    setState(() {
      widget.tasklen = tasklength.toString();
    });

    _lastCompletion = DateTime.fromMillisecondsSinceEpoch(_prefs.getInt(
            'lastCompletion ${widget.btnText + widget.index.toString()}') ??
        0);
  }

  bool _canPerformTask() {
    DateTime now = DateTime.now();
    Duration difference = now.difference(_lastCompletion);

    return difference.inHours >= 24;
  }

  void _performTask() async {
    if (widget.index == 0 ||
        _prefs.getBool('task ${widget.index - 1}') == true) {
      if (_canPerformTask()) {
        Navigator.pushNamed(context, '/tracking', arguments: {
          "link": widget.url,
          "coin": widget.winCoin,
          "seconds": widget.stayTime,
          "type": "task",
          "index": widget.index.toString(),
          "id": widget.index.toString(),
          "taskname":
              'lastCompletion ${widget.btnText + widget.index.toString()}',
          "tasklen": widget.tasklen,
        });
      } else {
        // Display a message indicating the user needs to wait
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(textAlign: TextAlign.center, 'Task Locked'),
              content: const Text(
                  textAlign: TextAlign.center,
                  'You can perform this task again in 24 hours.'),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(textAlign: TextAlign.center, 'Task Locked'),
            content: const Text(
                textAlign: TextAlign.center,
                'Perform previous task to unlock this.'),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    _performTask();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: widget.color,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        widget.btnText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const AdMarkBottom(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Complete task in ${widget.stayTime} Seconds to win ${widget.winCoin} coins",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
