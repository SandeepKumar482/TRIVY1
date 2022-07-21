import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:trivy/appColor.dart';

class Sharer extends StatefulWidget {
  @override
  _SharerState createState() => _SharerState();
}

class _SharerState extends State<Sharer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TimelineList("1. Make a list of your travel and luggage details. ",
            "To get the best match, fill out the essential personal and forthcoming travel details on the trivy platform. "),
        TimelineList(
            "2. Match with a potential travel companion to share your luggage with",
            "Connect with the precisely matched luggage partner and begin sharing the burden via trivy as instructed."),
        TimelineList(
            "3. Confirm your booking, pay, and hand over your luggage ",
            "Once you've been connected with your luggage buddy using trivy, give or take the scanned luggage to your travel companion and continue traveling safely. "),
        TimelineList("4. Travel in comfort ",
            "Overcome the age-old luggage worries and look forward to a no compromise journey."),
        TimelineList("5. Pick and Pay",
            "Pick up your luggage from your luggage companion and pay or receive the fee from them at your destination's airport."),
      ],
    );
  }
}

class TimelineList extends StatelessWidget {
  String str;
  String head;
  TimelineList(this.head, this.str);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 40.0),
      child: TimelineTile(
        alignment: TimelineAlign.left,
        isFirst: true,
        indicatorStyle: const IndicatorStyle(
          width: 20,
          indicatorY: 0.2,
          indicator: Icon(Icons.share),
          padding: EdgeInsets.all(8),
        ),
        rightChild: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [AppColor.c1, AppColor.c3])),
          child: Column(
            children: [
              //SvgPicture.asset(order_processed, height: 50, width: 50,),
              SizedBox(
                height: 10,
              ),
              Text(
                head,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColor.c4),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                str,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
