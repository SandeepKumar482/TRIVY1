import 'package:flutter/material.dart';
import 'package:trivy/admin.dart';
import 'package:trivy/appColor.dart';

class LoadingIndicator extends StatelessWidget{
  LoadingIndicator({this.text = '',this.head='Please Wait..'});

  final String text;
  final String head;
  @override
  Widget build(BuildContext context) {
    var displayedText = text;
    var heading=head;
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.black87.withOpacity(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getLoadingIndicator(),
          _getHeading(context,heading),
          _getText(displayedText)
        ]
      )
    );
  }

  Padding _getLoadingIndicator() {
    return Padding(
      child: Container(
        color: Colors.black87.withOpacity(0),
        child: CircularProgressIndicator(
          color: AppColor.c4,
          strokeWidth: 3
        ),
        width: 32,
        height: 32
      ),
      padding: EdgeInsets.only(bottom: 16)
    );
  }

  Widget _getHeading(context,heading) {
    return
      Padding(
        child: Text(
          heading,
          style: TextStyle(
          
            color: Colors.white,
            fontSize: 16
          ),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4)
      );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(
       
        color: Colors.white,
        fontSize: 14
      ),
      textAlign: TextAlign.center,
    );
  }

}