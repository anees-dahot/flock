import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap,
      required this.text});

  final double width;
  final double height;
  void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.8,
        height: height * 0.07,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        )),
      ),
    );
  }
}
