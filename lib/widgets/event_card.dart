import 'package:event_app/models/event.dart';
import 'package:event_app/provider/user_provider.dart';
import 'package:event_app/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  final List<EventModel> event;
  final Function deleteTx;
  final bool isNotPastEvent;

  const EventList(this.event, this.deleteTx, this.isNotPastEvent,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) => SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                event[i].name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              trailing:
                  (Provider.of<UserProvider>(context).userModel!.usertype! ==
                              'faculty' &&
                          !isNotPastEvent)
                      ? Wrap(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                )),
                            const SizedBox(
                              width: 0,
                            ),
                            IconButton(
                                onPressed: () {
                                  deleteTx(event[i].id);
                                },
                                icon: const Icon(Icons.delete, size: 20)),
                          ],
                        )
                      : const Text(''),
              leading: CircleAvatar(
                radius: 28.0,
                backgroundImage: NetworkImage(event[i].img),
              ),
              subtitle: Text(
                "Organisers: ${event[i].organisers}\n"
                "Event date : ${event[i].eDate}",
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  EventDetailScreen.routeName,
                  arguments: event[i].id,
                );
                print(isNotPastEvent);
              },
              horizontalTitleGap: 30,
              minVerticalPadding: 20,
              minLeadingWidth: 65,
            ),
            const Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
      itemCount: event.length,
    );
  }
}
