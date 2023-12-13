import 'package:event_app/provider/user_provider.dart';
import 'package:event_app/screens/add_event_screen.dart';
import 'package:event_app/screens/list_of_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: null,
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            toolbarHeight: 100,
            title: Text(Provider.of<UserProvider>(context).userModel!.name!),
            automaticallyImplyLeading: false,
            leading: CircleAvatar(
              child: IconButton(
                color: Colors.white,
                icon: (Image.asset(
                  "assets/images/profileImg.png",
                  width: 70,
                  height: 70,
                )),
                onPressed: () {},
              ),
            ),
            elevation: 100,
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.account_balance,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('All Events'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ListOfEventScreen.routeName,
                    arguments: 'All Events',
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.account_balance,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Other Events'),
                onTap: () {},
              ),
              const Divider(),
              if (Provider.of<UserProvider>(context).userModel!.usertype! ==
                  'faculty')
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Add Event'),
                  onTap: () {
                    Navigator.of(context).pushNamed(AddEventScreen.routeName,arguments: 'Add Event');
                  },
                ),
              if (Provider.of<UserProvider>(context).userModel!.usertype! ==
                  'faculty')
                const Divider(),
              ListTile(
                leading: Icon(
                  Icons.dark_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Past Event'),
                onTap: () {
                  Navigator.of(context).pushNamed(ListOfEventScreen.routeName, arguments: 'Past Event');
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Logout'),
                onTap: () async{
                  Provider.of<UserProvider>(context, listen: false).logout();
                },
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}
