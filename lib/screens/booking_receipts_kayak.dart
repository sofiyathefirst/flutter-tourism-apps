import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingReceiptsKayak extends StatefulWidget {
  BookingReceiptsKayak({Key? key}) : super(key: key);

  @override
  State<BookingReceiptsKayak> createState() => _BookingReceiptsKayakState();
}

class _BookingReceiptsKayakState extends State<BookingReceiptsKayak> {
  final bookingKayak = FirebaseFirestore.instance.collection('booking_kayak');

  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  get activityname => null;

  getDataById() async {
    final String userid = currentUser.toString();
    final DocumentSnapshot ds = await bookingKayak.doc(userid).get();

    final String cityname = ds.get('cityname').toString();
    final String activityname = ds.get('activityname').toString();
    final String adults = ds.get('adults').toString();
    final String date = ds.get('date').toString();
    final String name = ds.get('name').toString();
    final String pnum = ds.get('pnum').toString();
    final String time = ds.get('time').toString();
    final String total = ds.get('total').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Booking Receipt',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getDataById(),
          ],
        ),
      ),
    );
  }
}
