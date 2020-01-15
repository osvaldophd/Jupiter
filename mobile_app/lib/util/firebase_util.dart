import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/model/models.dart';

class FirebaseUtil{

  static final db = Firestore.instance;
  final VanBloc _vanBloc = BlocProvider.getBloc<VanBloc>();
  static String matricula = '';
  static String marca = '';
  static String modelo = '';
  static String imagem = '';
  static String lugares = '';

  FirebaseUtil(){
    SharedPreferences.getInstance().then((prefs) {
      matricula = prefs.getString('matricula');
      marca = prefs.getString('marca');
      modelo = prefs.getString('modelo');
      imagem = prefs.getString('imagem');
      lugares = prefs.getString('lugares');
    });
  }

  void addLocation(double latitude, double longitude) async {
    bool achou = false;
    String id;

    db.collection("localizacaoVans").getDocuments().then((localizacaoVans)async {
      localizacaoVans.documents.forEach((data) {
        var localizacao = LocationVanUser.fromJson(data);
        if(localizacao.matricula == matricula){
          achou = true;
          id = localizacao.idDocument;
        }
      });
      if(achou && id != null){
        await db.document('localizacaoVans/$id').updateData({
            'marca': marca,
            'modelo': modelo,
            'imagem': imagem,
            'lugares': lugares,
            'latitude': latitude, 
            'longitude': longitude
          });
      } else{
        await db.collection('localizacaoVans').document()
          .setData({ 
            'matricula': matricula,
            'marca': marca,
            'modelo': modelo,
            'imagem': imagem,
            'lugares': lugares,
            'latitude': latitude, 
            'longitude': longitude 
          });
      }
    });
  }

  List<LocationVanUser> getLocationsUsers(){
    List<LocationVanUser> locations = [];
    // print("data0");
    db.collection('localizacaoVans').snapshots().listen((onData){
    // print("data1");
      onData.documents.forEach((snapShot){
    // print("data2 ${snapShot.data}");
        locations.add(LocationVanUser.fromJson(snapShot));
      });
    });
    return locations;
  }

  static void updateLocationIfNotExists(){
    
  }

}