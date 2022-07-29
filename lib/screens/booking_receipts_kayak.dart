import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/screens/home_screen.dart';
import 'package:test_project/screens/login_screen.dart';
import 'package:test_project/screens/main_screen.dart';

class BookingReceiptsKayak extends StatefulWidget {
  BookingReceiptsKayak({Key? key}) : super(key: key);

  @override
  State<BookingReceiptsKayak> createState() => _BookingReceiptsKayakState();
}

class _BookingReceiptsKayakState extends State<BookingReceiptsKayak> {
  final bookingKayak = FirebaseFirestore.instance.collection('booking_kayak');

  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  Future<void> _delete(String bookingId) async {
    await bookingKayak.doc(bookingId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Delete Succesful'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 243, 245),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.black),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage(title: 'Login Page')));
            },
          ),
        ],
        title: const Text(
          'Booking Receipt',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: bookingKayak.get(),
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
                final sd = snapshot.data!.docs;

                return Column(
                    children: List.generate(sd.length, (i) {
                  final trip = sd[i];

                  if (currentUser == trip.get('uid')) {
                    return Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          color: Colors.teal[300],
                          width: double.infinity,
                          child: Column(
                            // ignore: sort_child_properties_last
                            children: [
                              Text(
                                trip.get('activityname'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text('Booker Name: ' + trip.get('name')),
                              SizedBox(height: 20),
                              Text('Booker Phone Number: ' + trip.get('pnum')),
                              SizedBox(height: 20),
                              Text('City: ' + trip.get('cityname')),
                              SizedBox(height: 20),
                              Text('Date: ' + trip.get('date')),
                              SizedBox(height: 20),
                              Text('Time: ' + trip.get('time')),
                              SizedBox(height: 20),
                              Text('Number of Adults: ' + trip.get('adults')),
                              SizedBox(height: 20),
                              Text('Total Price: RM' +
                                  trip.get('totalprice').toString()),
                              SizedBox(height: 20),
                              Text(
                                '*** Please bring this booking receipts to claim your ticket at the counter ***',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  _delete(trip.id);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BookingReceiptsKayak()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red.shade800),
                                ),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [],
                    );
                  }
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
