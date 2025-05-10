import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/destination_provider.dart';
import 'package:flutter_application_2/screens/destinations/destination_create_screen.dart';
import 'package:flutter_application_2/screens/destinations/destination_detail_screen.dart';
import 'package:provider/provider.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Pantai Kuta',
      'description':
          'Pantai terkenal di Bali dengan pasir putih dan sunset yang indah.',
      'imageUrl': 'https://picsum.photos/600/300',
      'rating': 4.5,
    },
    {
      'name': 'Candi Borobudur',
      'description':
          'Candi Buddha terbesar di dunia yang terletak di Magelang, Jawa Tengah.',
      'imageUrl': 'https://picsum.photos/600/300',
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final destinationProvider = Provider.of<DestinationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinasi Wisata'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DestinationCreateScreen();
                  },
                ),
              );
            },
            tooltip: 'Tambah Destination',
          ),
        ],
      ),
      body: StreamBuilder(
        stream: destinationProvider.destinations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('loading ...'));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data destinasi.'));
          }

          final destinations = snapshot.data!;

          return ListView.builder(
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final dest = destinations[index];
              return Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        dest.image,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dest.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dest.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(dest.rating.toString()),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigasi ke halaman detail akan ditambahkan nanti
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              DestinationDetailScreen(DestinationId: dest.id),
                                    ),
                                  );
                                },
                                child: const Text('Detail'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
