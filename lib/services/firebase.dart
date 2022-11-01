import 'package:cloud_firestore/cloud_firestore.dart';

Future userSetup(
    String name, String pnum, String email, String password) async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': name,
    'phonenum': pnum,
    'email': email,
    'password': password,
  });
}
