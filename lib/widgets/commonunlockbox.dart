import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games/variables/modal_variable.dart';

class CommonUnlockBox extends StatelessWidget {
  final String text;
  final double fontSize;
  const CommonUnlockBox({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          if (text == 'Get Code') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      "Reedem Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  content: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                          controller: TextEditingController(
                              text: otherLinksModel.otherlinks![10].link),
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green,
                            border: const OutlineInputBorder(),
                            hintText: otherLinksModel.otherlinks![10].link,
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green)),
                        onPressed: () {
                          // _prefs.setBool(isActiveLabel, false);
                          Clipboard.setData(ClipboardData(
                              text: otherLinksModel.otherlinks![4].link));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Copied to clipboard',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Copy',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(textAlign: TextAlign.center, 'Task Locked'),
                  content: const Text(
                      textAlign: TextAlign.center,
                      'Minimum 1000 Coins required to Unlock'),
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
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: const Color.fromARGB(255, 7, 28, 255),
          elevation: 10.0,
          color: Colors.green,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height * 0.17,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
