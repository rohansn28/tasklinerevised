import 'package:flutter/material.dart';
import 'package:games/variables/local_variables.dart';

class Commontop extends StatelessWidget {
  const Commontop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height / 8.9 + 20,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
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
    );
  }
}
