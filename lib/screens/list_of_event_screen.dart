import 'package:event_app/provider/event_provider.dart';
import 'package:event_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../firebase_stuff/firestore_constant.dart';
import '../models/event.dart';

class ListOfEventScreen extends StatefulWidget {
  static const routeName = '/upcoming-event-screen';

  const ListOfEventScreen({super.key});

  @override
  State<ListOfEventScreen> createState() => _ListOfEventScreenState();
}

class _ListOfEventScreenState extends State<ListOfEventScreen> {
  bool dataFetched = false;

  final List<EventModel> requiredEvent = [];
  List<EventModel> eventData = [];
  var _isInit = true;
  var _isLoading = false;
  List<EventModel>? selectedEventList = [];
  String? pageTitle;
  String isCheckPastEvent = 'Past Event';

  @override
  void didChangeDependencies() {
    if (!dataFetched) {
      eventData = Provider.of<EventProvider>(context).event;
      pageTitle = ModalRoute.of(context)!.settings.arguments as String;
      requiredEventCall();
    }
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<EventProvider>(context).fetchEventData().then((_) {
        eventData = Provider.of<EventProvider>(context, listen: false).event;
        requiredEventCall();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    dataFetched = true;

    super.didChangeDependencies();
  }

  void requiredEventCall() async {
    requiredEvent.clear();
    setState(() {
      _isLoading = true;
    });
    for (EventModel event in eventData) {
      DateFormat dFormat = DateFormat("dd/MM/yyyy");
      DateTime now = DateTime.now();
      DateTime eDate = dFormat.parse(event.eDate);
      String dFormat2 = DateFormat('dd/MM/yyyy').format(now);
      DateTime dNow = dFormat.parse(dFormat2);
      if (isCheckPastEvent == pageTitle) {
        if (eDate.isBefore(dNow)) {
          requiredEvent.add(event);
        }
      } else if ('Upcoming Event' == pageTitle) {
        if (eDate.isAfter(dNow) || eDate.isAtSameMomentAs(dNow)) {
          requiredEvent.add(event);
        }
      } else {
        requiredEvent.add(event);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void deleteEvent(String id) async {
    setState(() {
      _isLoading = true;
    });
    requiredEvent.removeWhere((element) => element.id == id);
    await db.collection("Event").doc(id).delete();
    // dataFetched = false;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          pageTitle!,
          style: const TextStyle(
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
          : RefreshIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
              onRefresh: () async {
                Provider.of<EventProvider>(context, listen: false)
                    .fetchEventData();
              },
              child: Stack(
                children: [
                  requiredEvent.isEmpty
                      ? const Center(child: Text('There is no event in here.'))
                      : EventList(requiredEvent, deleteEvent, isCheckPastEvent == pageTitle)
                ],
              ),
            ),
    );
  }
}
