import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_project/screens/booking_receipts_kayak.dart';

//final selectedCity = StateProvider((ref) => '');

class BookingPage extends StatefulWidget {
  final QueryDocumentSnapshot<Object?>? data;
  const BookingPage({Key? key, this.data}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final dropdownState = GlobalKey<FormFieldState>();

  final TextEditingController date = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController pnum = TextEditingController();
  final TextEditingController adults = TextEditingController();
  final TextEditingController child = TextEditingController();
  final TextEditingController total = TextEditingController();
  final TextEditingController email = TextEditingController();
  late String currenttime;
  late int currentadult;
  late int currentchild;
  late String cityname = widget.data!.get('city');
  late String activityname = widget.data!.get('name');
  late int priceadult = widget.data!.get('price_adults');
  late int pricechild = widget.data!.get('price_child');
  late List<String> time = List.from(widget.data!.get('time'));
  late int sum;

  late int result = 0;
  _calculation() {
    setState(() {
      result = ((int.parse(adults.text) * int.parse(priceadult.toString())));
    });
    return result;
  }

  var currentUser = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference bookingKayak =
        FirebaseFirestore.instance.collection('booking_kayak');
    Add(String activityname, String cityname, String name, String pnum,
        String date, String time, String adults, int totalprice, var uid) {
      try {
        return bookingKayak.add({
          'activityname': activityname,
          'cityname': cityname,
          'name': name,
          'pnum': pnum,
          'date': date,
          'time': time,
          'adults': adults,
          'totalprice': result,
          'uid': uid,
        }).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking Succesful'),
            ),
          ),
        );
      } on FirebaseException catch (e) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.code),
        ));
      }
    }

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
          'Booking Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      activityname,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cityname,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            ' Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            ' Phone Number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: pnum,
                          decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            ' Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: date,
                          decoration: InputDecoration(
                            hintText: 'Enter your date',
                            prefixIcon: const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime
                                    .now(), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2023));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                date.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            ' Time',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          items: time.map((times) {
                            return DropdownMenuItem(
                              value: times,
                              child: Text('$times '),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() => currenttime = val.toString());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            ' Number of person',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: adults,
                          decoration: InputDecoration(
                            hintText: 'Enter number of adults',
                            prefixIcon: const Icon(
                              Icons.person_add_alt_1_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: Text(
                            'Total: RM $result',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: (_calculation),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green),
                                ),
                                child: const Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(
                                      () {},
                                    );
                                    Add(
                                      activityname,
                                      cityname,
                                      name.text,
                                      pnum.text,
                                      date.text,
                                      currenttime,
                                      adults.text,
                                      result,
                                      currentUser,
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BookingReceiptsKayak(),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.orangeAccent),
                                ),
                                child: const Text(
                                  'Book',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
