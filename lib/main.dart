import 'package:event_app/provider/event_provider.dart';
import 'package:event_app/provider/user_provider.dart';
import 'package:event_app/screens/add_event_screen.dart';
import 'package:event_app/screens/auth_screen.dart';
import 'package:event_app/screens/event_detail_screen.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:event_app/screens/notification_screen.dart';
import 'package:event_app/screens/splash_screen.dart';
import 'package:event_app/screens/list_of_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => EventProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: buildMaterialColor(const Color(0xFF186F65)),
            backgroundColor: buildMaterialColor(const Color(0xFF85E6C5)),
            accentColor: Colors.grey,
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const HomePage();
            }
            return const AuthScreen();
          },
        ),
        navigatorKey: navigatorKey,
        routes: {
          HomePage.routeNamed:(ctx)=>const HomePage(),
          ListOfEventScreen.routeName: (ctx) => const ListOfEventScreen(),
          EventDetailScreen.routeName: (ctx) => const EventDetailScreen(),
          AddEventScreen.routeName: (ctx) => const AddEventScreen(),
          NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
          // AuthScreen.routeName: (ctx) => const AuthScreen(),
        },
      ),
    );
  }
}
//
