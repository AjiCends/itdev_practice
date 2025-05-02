import 'package:flutter/material.dart';

void main() {
  runApp(ItDevApp());
}

class ItDevApp extends StatelessWidget {
  const ItDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> events = [
      {
        'name': 'event 1',
        'date': '12/04/2025',
      },
      {
        'name': 'event 2',
        'date': '12/04/2025',
      }
    ];

    final List<Map<String, String>> destinations = [
      {
        'name': 'Destination 1',
        'rating': '5',
      },
      {
        'name': 'Destinatioin 2',
        'rating': '4.5',
      }
    ];

    return MaterialApp(
      title: 'Destination Tourism',
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.map),
          title: const Text('Destination Tourism App'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: PageView(
                  children: [
                    Card(
                      child: Image.network(
                        'https://picsum.photos/id/10/300/300',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Card(
                      child: Image.network(
                        'https://picsum.photos/id/11/300/300',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Card(
                      child: Image.network(
                        'https://picsum.photos/id/12/300/300',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Explore By Category',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: const [
                  Card(
                    color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.beach_access),
                        SizedBox(height: 6),
                        Text('Pantai')
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.terrain),
                        SizedBox(height: 6),
                        Text('Gunung')
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.villa),
                        SizedBox(height: 6),
                        Text('Pedesaan')
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.apartment),
                        SizedBox(height: 6),
                        Text('Perkotaan')
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Upcoming Event',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var event in events)
                      ListTile(
                        title: Text("${event['name']}"),
                        subtitle: Text("${event['date']}"),
                        trailing: ElevatedButton(
                            onPressed: () {}, child: const Text('Detail')),
                      )
                  ]),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: destinations
                      .map((destination) => SizedBox(
                            width: 250,
                            child: Card(
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://picsum.photos/id/10/200/150',
                                    fit: BoxFit.cover,
                                  ),
                                  Text('${destination['name']}'),
                                  Text('rating : ${destination['rating']}'),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.compare_sharp), label: 'Explore')
          ],
        ),
      ),
    );
  }
}


