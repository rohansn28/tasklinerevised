import 'package:flutter/material.dart';
import 'package:games/variables/local_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeRemainingWidget extends StatefulWidget {
  final String seconds, link, coins, type, id, taskname, index;
  String tasklen;
  TimeRemainingWidget({
    super.key,
    required this.seconds,
    required this.link,
    required this.coins,
    required this.type,
    required this.id,
    required this.taskname,
    required this.index,
    required this.tasklen,
  });

  @override
  State<TimeRemainingWidget> createState() => _TimeRemainingWidgetState();
}

class _TimeRemainingWidgetState extends State<TimeRemainingWidget> {
  late final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  late final tasklength;

  @override
  void initState() {
    super.initState();
    // initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      tasklength = prefs.getInt(tasklenghtLabel);
      widget.tasklen = tasklength.toString();
    });
  }

  void handleCancelButton(context) {
    removePrefs();
    Navigator.pop(context);
  }

  void handleContinueButton(context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/tracking", arguments: {
      'link': widget.link,
      'coin': widget.coins.toString(),
      'seconds': widget.seconds,
      'type': widget.type,
      'id': widget.id,
      "index": widget.index,
      'taskname': widget.taskname,
      'tasklen': widget.tasklen,
    });
  }

  void removePrefs() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("coin");
    prefs.remove(prefs.getString("currentLink")!);
    prefs.remove("currentLink");
    prefs.remove("type");
    prefs.remove("id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 3, color: Colors.white)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (int.parse(widget.seconds) / 60)
                                .toString()
                                .toString()
                                .substring(0, 1),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            "MINUTES",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 3, color: Colors.white)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (int.parse(widget.seconds) % 60).toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            "SECONDS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You need to play for a little more time to win coins for this session!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      handleCancelButton(context);
                    },
                    minWidth: 120,
                    color: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text("Close"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      handleContinueButton(context);
                    },
                    minWidth: 120,
                    color: Colors.amber.shade700,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
