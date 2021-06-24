import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  FollowButton({
    Key? key,
    required this.onPressed,
    required this.followed,
  }) : super(key: key);

  final Function onPressed;
  final bool followed;

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late var flag = widget.followed;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey),
          foregroundColor: MaterialStateColor.resolveWith((states) {
            // if (states.contains(MaterialState.pressed)) {
            //   return Colors.green;
            // }
            return Colors.white;
          }),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => flag ? Colors.grey : Colors.pink)),
      label: flag ? Text("取消关注") : Text("关注"),
      icon: flag ? Icon(Icons.clear) : Icon(Icons.add),
      onPressed: () {
        flag = !flag;
        setState(() {});
        widget.onPressed(flag);
      },
    );
  }
}
