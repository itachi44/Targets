import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final databaseReference = Firestore.instance;

void createRecord(Position pos) async {
  DocumentReference ref = await databaseReference.collection("position")
      .add(pos.toJson());
  print(ref.documentID);
}

class Position {
  String key;
  double lat;
  double long;
  DateTime date = DateTime.now();

  //For getting Position
  Position.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        lat = snapshot.value["lat"],
        long = snapshot.value["long"]
        //date = snapshot.value["date"]
        ;
      
  //For saving the current position

  Position(LatLng latLng){
    this.lat = latLng.latitude;
    this.long = latLng.longitude;
  }

  toJson() {
    return {
      "lat": lat,
      "long": long,
      "date": date,
    };
  }
  addNewTodo(database) {
    if (this.lat!=0 && this.long!=0) {

      database.reference().child("position").push().set(this.toJson());
    }
  }
  // save() {
  //   CloudFunctions.instance.call(functionName: "addUser", parameters: {
  //     "name": _nameTextController.text,
  //     "email": _emailTextController.text
  //   });
  // }
}
