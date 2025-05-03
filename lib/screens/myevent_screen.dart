import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/event_registered_provider.dart';
import 'package:provider/provider.dart';

class MyEventScreen extends StatelessWidget {
  const MyEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Events Saya'),
      ),
      body: Consumer(
        builder: (
          BuildContext context,
          EventRegisteredProvider eventRegistered,
          child,
        ) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final registered = eventRegistered.getAllRegistered()[index];
              final event = eventRegistered.getEventById(registered.eventId);

              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 100,
                  child: Image.network(
                    'https://picsum.photos/id/${event?.id}/300/200',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('${event?.name}'),
                subtitle: Text("${event?.date}"),
              );
            },
            separatorBuilder:
                (BuildContext context, int index) => const Divider(),
            itemCount: eventRegistered.getAllRegistered().length,
          );
        },
      ),
    );
  }
}
