import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games/variables/modal_variable.dart';

class CommonUnlockBox extends StatelessWidget {
  final String text;
  final String? deviceid, shareText;
  final double fontSize;
  const CommonUnlockBox({
    super.key,
    required this.text,
    required this.fontSize,
    this.deviceid,
    this.shareText,
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
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Text(
                      shareText!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Code',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                                controller: TextEditingController(
                                  text: otherLinksModel.otherlinks![10].link,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.green,
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      otherLinksModel.otherlinks![10].link,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: otherLinksModel.otherlinks![10].link,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Copied to clipboard',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.copy,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Device ID',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                                controller: TextEditingController(
                                  text: deviceid,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.green,
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      otherLinksModel.otherlinks![10].link,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: deviceid!,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Copied to clipboard',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.copy,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.green,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
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
                  title: const Text(
                    textAlign: TextAlign.center,
                    'Game Locked',
                  ),
                  content: const Text(
                    textAlign: TextAlign.center,
                    'Reach a level to Unlock',
                  ),
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
