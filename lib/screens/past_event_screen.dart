import 'package:event_app/provider/event_provider.dart';
import 'package:event_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';

class PastEventScreen extends StatefulWidget {
  static const routeName = '/past_event_screen';

  const PastEventScreen({super.key});

  @override
  State<PastEventScreen> createState() => _PastEventScreenState();
}

class _PastEventScreenState extends State<PastEventScreen> {
  bool dataFetched = false;

  late List<EventModel> eventData = [];

  final List<EventModel> pastEvent = [];
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!dataFetched) {
      eventData = Provider.of<EventProvider>(context).event2;
      pastEventCall();
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

  void pastEventCall() async {
    pastEvent.clear();
    for (EventModel event in eventData) {
      DateFormat dFormat = DateFormat("dd/MM/yyyy");
      DateTime now = DateTime.now();
      DateTime eDate = dFormat.parse(event.eDate);
      String dFormat2 = DateFormat('dd/MM/yyyy').format(now);
      DateTime dNow = dFormat.parse(dFormat2);
      if (eDate.isBefore(dNow)) {
        pastEvent.add(event);
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
          'List of Past Events',
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
                pastEvent[i].id,
                pastEvent[i].name,
                pastEvent[i].img,
                pastEvent[i].organisers,
                pastEvent[i].location,
              ),
              itemCount: pastEvent.length,
            ),
    );
  }
}
