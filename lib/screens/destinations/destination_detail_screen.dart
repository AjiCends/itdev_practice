import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/destination_provider.dart';
import 'package:flutter_application_2/screens/destinations/destination_screen.dart';
import 'package:flutter_application_2/screens/destinations/destination_update_screen.dart';
import 'package:provider/provider.dart';

class DestinationDetailScreen extends StatefulWidget {
  final String DestinationId;
  const DestinationDetailScreen({super.key, required this.DestinationId});

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  var _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() async {
      await Provider.of<DestinationProvider>(
        context,
        listen: false,
      ).find(widget.DestinationId);

      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Destination')),
      body: Consumer<DestinationProvider>(
        builder: (context, destinationProvider, child) {
          final destination = destinationProvider.detail;

          if (destination == null) {
            return const Center(child: Text('data tidak ditemukan'));
          }

          if (_loading == true) {
            return const Center(child: Text('loading ...'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  destination.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  destination.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(destination.description, style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(
                      destination.rating.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DestinationUpdateScreen(
                                destinationId: widget.DestinationId,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        _loading = true;
                        await destinationProvider.delete(widget.DestinationId);
                        _loading = false;

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) {
                              return DestinationScreen();
                            },
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
