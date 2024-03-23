import 'package:flutter/material.dart';
import 'package:games/variables/local_variables.dart';

class Commontop extends StatelessWidget {
  const Commontop({
    super.key,
    required this.refreshCallback,
  });

  final VoidCallback refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 8.9 + 20,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: Column(
                    children: [
                      const Text(
                        'Coins',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        gameCoins.toString(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 8.9 + 20,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: Column(
                    children: [
                      const Text(
                        'Value',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        (gameCoins / 100).toString(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2.8,
              top: (MediaQuery.of(context).size.height / 10) / 3,
              child: InkWell(
                onTap: refreshCallback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color.fromARGB(255, 98, 42, 71),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    size: 45.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
