import 'package:flutter/material.dart';
import 'package:ws_test_app/util/constant.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w(context) * .6,
      height: h(context) * .07,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style:const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
