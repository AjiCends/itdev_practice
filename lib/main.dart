import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/providers/destination_provider.dart';
import 'package:flutter_application_2/providers/event_provider.dart';
import 'package:flutter_application_2/providers/event_registered_provider.dart';
import 'package:flutter_application_2/screens/home/wrapper.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProxyProvider<EventProvider, EventRegisteredProvider>(
          create: (context) => EventRegisteredProvider(),
          update: (context, eventProvider, eventRegisteredProvider) {
            eventRegisteredProvider!.events = eventProvider.getAllEvents();
            return eventRegisteredProvider;
          },
        ),
        ChangeNotifierProvider(create: (context) => DestinationProvider()),
        StreamProvider<UserModel?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: ItDevApp(),
    ),
  );
}

class ItDevApp extends StatelessWidget {
  const ItDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Destination Tourism', home: Wrapper());
  }
}
