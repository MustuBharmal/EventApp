  import 'package:flutter/material.dart';

  import '../widgets/auth_card.dart';

  class AuthScreen extends StatelessWidget {
    static const routeName = '/auth';

    const AuthScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final deviceSize = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    // bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  width: 210,
                  child: Image.asset(
                    "assets/images/ic_launcher.png",
                    height: 230,
                    width: 230,
                  ),
                ),
                // Flexible(
                //   flex: deviceSize.width > 600 ? 2 : 1,
                const AuthCard(),
                // ),
              ],
            ),
          ),
        ),
      );
    }
  }
