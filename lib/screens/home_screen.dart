import 'package:event_app/provider/user_provider.dart';
import 'package:event_app/screens/past_event_screen.dart';
import 'package:event_app/screens/upcoming_event_screen.dart';
import 'package:event_app/widgets/button_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/image_slider.dart';
import '../widgets/profile_popup.dart';
import 'add_event_screen.dart';

var imageString1 = "assets/images/notification_1.png";
var imageString2 = "assets/images/notification_2.png";
var imageString3 = "assets/images/add_event.png";

class HomePage extends StatefulWidget {
  static const routeNamed = '/homepage_screen';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    // notificationSettings.announcement;
    await fcm.getToken();
    fcm.subscribeToTopic('event');
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
        (_) => Provider.of<UserProvider>(context, listen: false).getUserData());
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: const Text(
            'Eventify',
            style: TextStyle(
              // color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person_2_outlined,
              // color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const ProfilePopup();
                },
              );
            },
          ),
        ],
      ),
      drawer:const AppDrawer(),
      body: Provider.of<UserProvider>(context).userModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  ImageSlider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, UpcomingEventScreen.routeName);
                        },
                        child: Row(
                          children: [
                            ButtonWidget(imageString1, "Upcoming Event",
                                UpcomingEventScreen.routeName),
                            Column(
                              children: [
                                titleSection('Upcoming Event',
                                    'An upcoming event is a\nplanned occurrence that\nis scheduled to take place\nin the near future'),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PastEventScreen.routeName);
                        },
                        child: Row(
                          children: [
                            ButtonWidget(imageString2, "Past Event",
                                PastEventScreen.routeName),
                            titleSection('Past Event',
                                'A past event is an event\nthat has already happened\n& is no longer in the present\nor future.'),
                          ],
                        ),
                      ),
                      if (Provider.of<UserProvider>(context)
                              .userModel!
                              .usertype! ==
                          'faculty')
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AddEventScreen.routeName);
                          },
                          child: Row(
                            children: [
                              ButtonWidget(imageString3, "Add Event",
                                  AddEventScreen.routeName),
                              titleSection('Add Event',
                                  'Adding an event is the\nprocess for creating event\nfor participant to register\nin it.'),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }

  Widget titleSection(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            description,
            softWrap: true,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
