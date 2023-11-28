import 'package:event_app/provider/event_provider.dart';
import 'package:event_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';

class UpcomingEventScreen extends StatefulWidget {
  static const routeName = '/upcoming_event_screen';

  const UpcomingEventScreen({super.key});

  @override
  State<UpcomingEventScreen> createState() => _UpcomingEventScreenState();
}

class _UpcomingEventScreenState extends State<UpcomingEventScreen> {
  bool dataFetched = false;

  final List<EventModel> upcomingEvent = [];
  late List<EventModel> eventData = [];
  var _isInit = true;
  var _isLoading = false;
  List<EventModel>? selectedEventList = [];

  // Future<void> _openFilterDialog() async {
  //   await FilterListDialog.display<EventModel>(
  //     context,
  //     hideSelectedTextCount: true,
  //     themeData: FilterListThemeData(context),
  //     headlineText: 'Select Users',
  //     height: 500,
  //     listData: Provider.of<EventProvider>(context, listen: false).allEvent,
  //     selectedListData: selectedEventList,
  //     choiceChipLabel: (item) => item!.name,
  //     validateSelectedItem: (list, val) => list!.contains(val),
  //     controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
  //     onItemSearch: (user, query) {
  //       return user.name.toLowerCase().contains(query.toLowerCase());
  //     },
  //     onApplyButtonClick: (list) {
  //       setState(() {
  //         selectedEventList = List.from(list!);
  //       });
  //       Navigator.pop(context);
  //     },
  //   );
  // }

  @override
  void didChangeDependencies() {
    if (!dataFetched) {
      eventData = Provider.of<EventProvider>(context).event2;
      upcomingEventCall();
    }
    dataFetched = true;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<EventProvider>(context).fetchEventData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void upcomingEventCall() async {
    upcomingEvent.clear();
    for (EventModel event in eventData) {
      DateFormat dFormat = DateFormat("dd/MM/yyyy");
      DateTime now = DateTime.now();
      DateTime eDate = dFormat.parse(event.eDate);
      String dFormat2 = DateFormat('dd/MM/yyyy').format(now);
      DateTime dNow = dFormat.parse(dFormat2);
      if (eDate.isAfter(dNow) || eDate.isAtSameMomentAs(dNow)) {
        upcomingEvent.add(event);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) => EventCard(
                upcomingEvent[i].id,
                upcomingEvent[i].name,
                upcomingEvent[i].img,
                upcomingEvent[i].organisers,
                upcomingEvent[i].eDate,
              ),
              itemCount: upcomingEvent.length,
            ),
    );
  }
}
/* bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: _openFilterDialog,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF85E6C5)),
              ),
              child: const Text(
                "Filter Dialog",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.blue,
            ),
          ],
        ),
      ),*/
