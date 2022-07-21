import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  
  final String text;
  final VoidCallback onClicked;
  final Color c3 =  Color(0xff4ecca3);
  ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: onClicked,
        color: c3,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      );
}
