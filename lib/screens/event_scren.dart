import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/event_provider.dart';
import 'package:flutter_application_2/screens/event_detail_screen.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

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
        title: Text('Daftar Event'),
      ),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          var events = eventProvider.getAllEvents();
          return ListView.separated(
            itemBuilder: (BuildContext context, index) {
              var event = events[index];
              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 100,
                  child: Image.network(
                    'https://picsum.photos/id/${event.id}/300/200',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(event.name),
                subtitle: Text(event.date),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EventDetail(eventId: event.id);
                        },
                      ),
                    );
                  },
                  child: const Text('Detail'),
                ),
              );
            },
            separatorBuilder: (BuildContext context, index) => const Divider(),
            itemCount: events.length,
          );
        },
      ),
    );
  }
}
