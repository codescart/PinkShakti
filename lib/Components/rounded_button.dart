import 'package:flutter/material.dart';
import 'package:pinkPower/Constant/color.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 12,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 10, left: 5),
          height: 50,
          width: size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: PinkColors),
          child: child),
    );
  }
}
