import 'package:event_app/screens/event_detail_screen.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String? id;
  final String name;
  final String imageUrl;
  final String org;
  final String eDate;

  const EventCard(this.id, this.name, this.imageUrl, this.org, this.eDate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            leading: CircleAvatar(
              radius: 28.0,
              backgroundImage: NetworkImage(imageUrl),
            ),
            subtitle: Text(
              "Organisers: $org\n"
              "Event date : $eDate",
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                EventDetailScreen.routeName,
                arguments: id,
              );
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
    );
  }
}
