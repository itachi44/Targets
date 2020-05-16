import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final databaseReference = Firestore.instance;

void createRecord(Position pos) async {
  DocumentReference ref = await databaseReference.collection("position")
      .add(pos.toJson());
  print(ref.documentID);
}

class Position {
  String userId;
  double lat;
  double long;
  DateTime date = DateTime.now();

  //For saving the current position

  Position(LatLng latLng, String userId){
    this.userId = userId;
    this.lat = latLng.latitude;
    this.long = latLng.longitude;
  }

  toJson() {
    return {
      "lat": lat,
      "long": long,
      "date": date,
      "userId": userId,
    };
  }
}