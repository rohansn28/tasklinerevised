import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games/game_home.dart';
import 'package:games/model/applink.dart';
import 'package:games/utils/web.dart';
import 'package:games/variables/local_variables.dart';
import 'package:games/variables/modal_variable.dart';
import 'package:games/widgets/commonmincoinbar.dart';
import 'package:games/widgets/commonpremiumtask.dart';
import 'package:games/widgets/commontop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumScreen extends StatefulWidget {
  final String? deviceid;
  final String? sharetext;
  const PremiumScreen({
    super.key,
    this.deviceid,
    this.sharetext,
  });

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  String deviceid = "";
  String sharetext = "";
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    if (_prefs.getBool(isActiveLabel)!) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 0),
              child: Text(
                otherLinksModel.otherlinks![11].link,
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
                            hintText: otherLinksModel.otherlinks![10].link,
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
                            text: _prefs.getString(deviceIdLabel)!,
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.green,
                            border: const OutlineInputBorder(),
                            hintText: _prefs.getString(deviceIdLabel)!,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: deviceid,
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
                    setState(() {
                      _prefs.setBool(isActiveLabel, false);
                    });
                    var tasklen = _prefs.getInt(tasklenghtLabel)!;
                    _prefs.setBool("task ${tasklen - 1}", false);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final routes =
          ModalRoute.of(context)?.settings.arguments as Map<String, String?>;

      setState(() {
        deviceid = routes['deviceid']!;
        sharetext = routes['sharetext']!;
      });
    } catch (e) {
      print(e);
    }
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () async {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GameHome(),
              ),
            );
          },
        ),
        title: const Text('Clicks'),
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GameHome(),
              ),
            );
          });
        },
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
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder<List<Applink>>(
                    future: fetchclicklinks('clicklinks'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CommonPremiumTask(
                              btnText: 'TASK ${index + 1}',
                              stayTime: '18',
                              winCoin: '20',
                              url: snapshot.data![index].link,
                              index: index,
                              color: Colors.green,
                              tasklen: snapshot.data!.length.toString(),
                              // onIsActiveChanged: handleIsActiveChanged,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
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
