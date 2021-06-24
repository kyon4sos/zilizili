import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final Widget icon;

  final String label;
  final GestureTapCallback onTap;
  const CustomButton({
    required this.onTap,
    required this.label,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              icon,
              SizedBox(
                height: 10,
              ),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }
}
