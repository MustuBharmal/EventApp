import 'package:event_app/provider/event_provider.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:event_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';

class AllEventScreen extends StatefulWidget {
  static const routeNamed = '/all_event_screen';

  const AllEventScreen({super.key});

  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen> {
  bool dataFetched = false;

  List<EventModel> eventData = [];
  var _isInit = true;
  var _isLoading = false;
  List<EventModel>? selectedEventList = [];

  @override
  void didChangeDependencies() {
    if (!dataFetched) {
      eventData = Provider
          .of<EventProvider>(context)
          .event2;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              HomePage.routeNamed,
            );
          },
        ),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        title: const Text(
          'List of Events',
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
          : RefreshIndicator(

        onRefresh: () async {
          await Provider.of<EventProvider>(context, listen: false).fetchEventData();
        },
        child: ListView.builder(
          itemBuilder: (ctx, i) =>
              EventCard(
                eventData[i].id,
                eventData[i].name,
                eventData[i].img,
                eventData[i].organisers,
                eventData[i].eDate,
              ),
          itemCount: eventData.length,
        ),
      ),
    );
  }
}
