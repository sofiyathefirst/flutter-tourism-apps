import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/model/city_model.dart';

Future<List<CityModel>> getCities() async {
  var cities = new List<CityModel>.empty(growable: true);
  var cityRef = FirebaseFirestore.instance.collection('AllTicket');
  var snapshot = await cityRef.get();
  snapshot.docs.forEach((element) {
    cities.add(CityModel.fromJson(element.data()));
  });
  return cities;
}
