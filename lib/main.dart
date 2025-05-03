import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/event_provider.dart';
import 'package:flutter_application_2/providers/event_registered_provider.dart';
import 'package:flutter_application_2/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
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
      ],
      child: ItDevApp(),
    ),
  );
}

class ItDevApp extends StatelessWidget {
  const ItDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Destination Tourism', home: HomeScreen());
  }
}
