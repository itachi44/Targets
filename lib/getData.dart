import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class Data{
  var data;
  var _connect = false;
  Map<String, String> map;

  getData(userId) async{
    await checkInternetConnectivity();
    if(_connect){
      await Firestore.instance.collection("User").document(userId).get().then((value){ 
        data = value.data;
        if (data!=null) {  
          map = {
            "prenom": data["prenom"],
            "nom" : data["nom"],
            "tel" : data["tel"],
          };
        }else
          print("There is nothing*****************************");

        return map;
      });
    }
  }
  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    _connect = (result == ConnectivityResult.none) ? false : true;
  }

}