import 'package:flutter/material.dart';

class CommonBoxNew extends StatefulWidget {
  final String text;

  final String route;
  final double fontSize;
  const CommonBoxNew({
    super.key,
    required this.text,
    required this.route,
    required this.fontSize,
  });

  @override
  State<CommonBoxNew> createState() => _CommonBoxNewState();
}

class _CommonBoxNewState extends State<CommonBoxNew> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, widget.route);
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
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.fontSize,
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
