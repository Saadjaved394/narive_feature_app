import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/placeProvider.dart';
import '../screens/add_places_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context,listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PlaceProvider>(
                child: const Center(
                  child: Text('No Places Yet add some'),
                ),
                builder: (ctx, placeProvider, ch) => placeProvider.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: placeProvider.items.length,
                        itemBuilder: (ctx, i) => Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2.5),
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image:
                                        FileImage(placeProvider.items[i].image),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                placeProvider.items[i].title,
                                style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
