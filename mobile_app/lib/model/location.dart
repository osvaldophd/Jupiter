import 'package:cloud_firestore/cloud_firestore.dart';

class LocationVanUser{

  final String _idDocument;
  final String _matricula;
  final String _marca;
  final String _modelo;
  final String _imagem;
  final String _lugares;
  final double _latitude;
  final double _longitude;

  LocationVanUser(
    this._idDocument, 
    this._matricula, 
    this._marca, 
    this._modelo, 
    this._imagem, 
    this._lugares, 
    this._latitude, 
    this._longitude);

  String get idDocument => _idDocument;
  String get matricula => _matricula;
  String get marca => _marca;
  String get modelo => _modelo;
  String get imagem => _imagem;
  String get lugares => _lugares;
  double get latitude => _latitude;
  double get longitude => _longitude;

  factory LocationVanUser.fromJson(DocumentSnapshot snapShot) {
    return LocationVanUser(
      snapShot.documentID, 
      snapShot.data['matricula'], 
      snapShot.data['marca'], 
      snapShot.data['modelo'], 
      snapShot.data['imagem'], 
      snapShot.data['lugares'], 
      snapShot.data['latitude'], 
      snapShot.data['longitude']
    );
  }

}