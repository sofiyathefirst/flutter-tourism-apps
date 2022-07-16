import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingReceiptsCruise extends StatefulWidget {
  BookingReceiptsCruise({Key? key}) : super(key: key);

  @override
  State<BookingReceiptsCruise> createState() => _BookingReceiptsCruiseState();
}

class _BookingReceiptsCruiseState extends State<BookingReceiptsCruise> {
  CollectionReference bookingKayak =
      FirebaseFirestore.instance.collection('booking_kayak');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [],
        ),
      ),
    );
  }
}
