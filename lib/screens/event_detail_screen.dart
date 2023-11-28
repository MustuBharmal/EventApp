import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/event_provider.dart';
import '../utility/color.dart';
import '../utility/text_style.dart';
import '../utility/ui_helper.dart';

late Uri _url;

class EventDetailScreen extends StatefulWidget {
  static const routeName = '/event_detail_screen';

  const EventDetailScreen({super.key});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late AnimationController bodyScrollAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late ScrollController scrollController;
  late Animation<double> scale;
  late Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= headerImageSize / 2) {
          if (!bodyScrollAnimationController.isCompleted) {
            bodyScrollAnimationController.forward();
          }
        } else {
          if (bodyScrollAnimationController.isCompleted) {
            bodyScrollAnimationController.reverse();
          }
        }
      });

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  DateFormat dFormat = DateFormat("dd/MM/yyyy");
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final detailId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedData = Provider.of<EventProvider>(
      context,
      listen: false,
    ).findById(detailId);
    DateTime eDate = dFormat.parse(loadedData.eDate);
    String dFormat2 = DateFormat('dd/MM/yyyy').format(now);
    DateTime dNow = dFormat.parse(dFormat2);
    _url = Uri.parse(loadedData.link);
    headerImageSize = MediaQuery.of(context).size.height / 2.5;
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: !eDate.isBefore(dNow) ? FloatingActionButton.extended(
            label: const Text(
              'Register',
              style: TextStyle(fontSize: 25),
            ),
            onPressed: () {
              _launchUrl();
            },
          ): const Text('Registration is Closed',style: TextStyle(fontSize: 20),),
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeaderImage(loadedData),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildEventTitle(loadedData),
                          UIHelper.verticalSpace(16),
                          buildEventDate(loadedData),
                          UIHelper.verticalSpace(24),
                          buildAboutEvent(loadedData),
                          UIHelper.verticalSpace(24),
                          UIHelper.verticalSpace(24),
                          UIHelper.verticalSpace(124),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderImage(var loadedData) {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta! / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: loadedData.img,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Image.network(
                  loadedData.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventTitle(var loadedData) {
    return Text(
      loadedData.name,
      style: headerStyle.copyWith(fontSize: 32),
    );
  }

  Widget buildEventDate(var loadedData) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Text('Location:-\n${loadedData.location}',
                style: subtitleStyle.copyWith(
                    color: Theme.of(context).primaryColor)),
          ),
        ),
        UIHelper.horizontalSpace(20),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              UIHelper.horizontalSpace(8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Event Data :- ${loadedData.eDate}',
                        style: subtitleStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                    Text('Registration end time :- ${loadedData.time}',
                        style: subtitleStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAboutEvent(var loadedData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("About", style: headerStyle),
        UIHelper.verticalSpace(),
        Text(loadedData.dsc, style: subtitleStyle),
        UIHelper.verticalSpace(8),
      ],
    );
  }
}
