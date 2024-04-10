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
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
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
                    style: const TextStyle(color: Colors.white),
                    controller: TextEditingController(
                        text: otherLinksModel.otherlinks![4].link),
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green,
                      border: const OutlineInputBorder(),
                      hintText: otherLinksModel.otherlinks![4].link,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    _prefs.setBool(isActiveLabel, false);
                    Clipboard.setData(ClipboardData(
                        text: otherLinksModel.otherlinks![10].link));
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
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              btnText: 'CLICK ${index + 1}',
                              stayTime: '2',
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
