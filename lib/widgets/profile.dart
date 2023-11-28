import 'package:event_app/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TopContainer(
      height: 10,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 70.0,
                  lineWidth: 3.0,
                  animation: true,
                  percent: 1,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.black,
                  // backgroundColor: Colors.yellow,
                  center: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      (Provider.of<UserProvider>(context).userModel!.img!),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      Provider.of<UserProvider>(context).userModel!.name!,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      (Provider.of<UserProvider>(context).userModel!.dept!),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
