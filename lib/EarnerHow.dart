import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:trivy/appColor.dart';

class Earner extends StatefulWidget {
  @override
  _EarnerState createState() => _EarnerState();
}

class _EarnerState extends State<Earner> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        eTimelineList("1. Make a list of your travel plans and luggage.",
            "Fill out your personal and forthcoming trip information on the trivy platform to get started on an exciting adventure"),
        eTimelineList("2. At the airport, meet up with your travel companion.",
            "Connect with the precisely matched luggage partner and begin sharing the burden via trivy as instructed."),
        eTimelineList("3. Take your matched travel companion's extra luggage.",
            "After you've been scanned, grab your travel companion's luggage and start sharing the weight. "),
        eTimelineList("4.Travel in comfort ",
            "Join forces with an exciting and rewarding travel opportunity. "),
        eTimelineList("5. Deal, drop, and go!",
            "At the destination airport, return the bag to the sharer and get your profit"),
      ],
    );
  }
}

class eTimelineList extends StatelessWidget {
  String head, str;
  eTimelineList(this.head, this.str);
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
          indicator: Icon(Icons.monetization_on),
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
