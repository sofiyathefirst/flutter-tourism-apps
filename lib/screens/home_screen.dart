import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/screens/booking_screen.dart';
import 'package:test_project/screens/booking_screens_cruise.dart';
import 'package:test_project/screens/information_screen_cruise.dart';
import 'package:test_project/screens/information_screen_kayak.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference dataStream =
      FirebaseFirestore.instance.collection('Kayak');
  final CollectionReference dataStream1 =
      FirebaseFirestore.instance.collection('Cruise');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 192, 243, 245),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.black),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
          title: const Text(
            'Home Screen',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              FutureBuilder(
                future: dataStream.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    //TODO: add snackbar
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final storedocs = snapshot.data!.docs;
                  return Column(
                    children: List.generate(storedocs.length, (i) {
                      final trip = storedocs[i];

                      return Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            color: Colors.tealAccent,
                            width: double.infinity,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 180,
                                  width: 130,
                                  child: Image(
                                    image: NetworkImage(trip.get('image')),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  // ignore: sort_child_properties_last
                                  children: [
                                    Text(
                                      trip.get('name'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text('City: ' + trip.get('city')),
                                    SizedBox(height: 20),
                                    Text('Price: RM' +
                                        trip.get('price_adults').toString() +
                                        ' per adults'),
                                    SizedBox(height: 20),
                                    Text('Duration: ' +
                                        trip.get('duration').toString() +
                                        ' hours'),
                                    SizedBox(height: 20),
                                    Text(
                                      '*** Only adults are allowed',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingPage(data: trip),
                                              ),
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                          ),
                                          child: const Text(
                                            'Book Now',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InformationPage2(
                                                        data: trip),
                                              ),
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                          ),
                                          child: const Text(
                                            'Details',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                },
              ),
              FutureBuilder(
                future: dataStream1.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    //TODO: add snackbar
                  }
                  final storedocs1 = snapshot.data!.docs;

                  return Column(
                    children: List.generate(
                      storedocs1.length,
                      (i) {
                        final trip = storedocs1[i];
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              color: Colors.tealAccent,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 180,
                                    width: 130,
                                    child: Image(
                                      image: NetworkImage(trip.get('image')),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    // ignore: sort_child_properties_last
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          trip.get('name'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text('City: ' + trip.get('city')),
                                      SizedBox(height: 20),
                                      Text('Price: RM' +
                                          trip.get('price_adults').toString() +
                                          ' per adults'),
                                      SizedBox(height: 20),
                                      Text('Price: RM' +
                                          trip.get('price_child').toString() +
                                          ' per child'),
                                      SizedBox(height: 20),
                                      Text('Duration: ' +
                                          trip.get('duration').toString() +
                                          ' hours'),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingPage2(
                                                            data: trip)),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                            ),
                                            child: const Text(
                                              'Book Now',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InformationPage(
                                                          data: trip),
                                                ),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                            ),
                                            child: const Text(
                                              'Details',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Booking Receipts'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          backgroundColor: const Color.fromARGB(255, 192, 243, 245),
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.black54,
        ),
      ),
    );
  }
}
