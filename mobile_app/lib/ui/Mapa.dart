import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app/ui/widgets/map_pin_pill.dart';
import 'package:mobile_app/util/map_util.dart';
import 'package:location/location.dart';
import 'package:mobile_app/model/models.dart';


class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  MapaPageSate createState() => new MapaPageSate();
}

class MapaPageSate extends State<MapaPage> with AutomaticKeepAliveClientMixin<MapaPage> {
  
  GoogleMapController _mapController;
  MapUtil mapUtil = new MapUtil();
  var currentLocation;
  bool _permission = false;
  String error;
  Location _locationService = new Location();
  LatLng _center = const LatLng(-8.8976318, 13.1855707);
  List<Polyline> rotas = new List();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor carIcon;
  bool done = false;

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
    pinPath: '', 
    avatarPath: '', 
    description:'', 
    description2:'', 
    title: '', 
    labelColor: Colors.grey);


  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/onboarding1.png')
        .then((onValue) {
      carIcon = onValue;
    });
    initPlatformState();
    updateMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  updateMarkers() {
    Firestore.instance
        .collection('localizacaoVans')
        .snapshots()
        .listen((data) {
      print("markes0 ${data.documents.length}");

      data.documents.forEach((snapshot) {
        
        var location = LocationVanUser.fromJson(snapshot);

        if(location.matricula != null){
          final MarkerId markerId = MarkerId(location.matricula);

          if (markers.containsKey(markerId)) {
            print("update");
            setState(() {
              print("${location.latitude}");
              final Marker resetOld = markers[markerId].copyWith(
                positionParam: LatLng(location.latitude, location.longitude));
              markers[markerId] = resetOld;
            });
          } else if(markerId != null) {
            print("save");

            setState(() {
              Marker newMarker = Marker(
                icon: carIcon,
                markerId: markerId,
                position: LatLng(location.latitude, location.longitude),
                // infoWindow: InfoWindow(title: location.nome),
                onTap: () {
                  setState(() {
                    currentlySelectedPin = PinInformation(
                      avatarPath: location.imagem, 
                      description: "${location.modelo} - ${location.marca}", 
                      title: location.matricula, 
                      description2: location.lugares, 
                      labelColor: Colors.grey
                    );
                    pinPillPosition = 0;
                  });
                },
              );
              markers[markerId] = newMarker;
            });
          }
        }


      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Stack(
        children: <Widget>[
          //---------------------------GOOGLE MAPS--------------------------
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 17.0,
            ),
            markers: Set<Marker>.of(markers.values),
            onTap: (LatLng location) {
              setState(() {
                pinPillPosition = -100;
              });
            },
          ),
          //---------------Info Pin-----------------
          MapPinPillComponent(
            pinPillPosition: pinPillPosition,
            currentlySelectedPin: currentlySelectedPin
          )
        ],
      ),
    );
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          final MarkerId markerId = MarkerId('localizacao');
          Marker marker = Marker(
            markerId: markerId,
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: 'Minha localização'),
          );
          print(location.latitude);
          if (mounted) {
            setState(() {
              currentLocation = LatLng(location.latitude, location.longitude);
              _center =
                  LatLng(currentLocation.latitude, currentLocation.longitude);
              markers[markerId] = marker;
              done = true;
              _mapController.animateCamera(
                CameraUpdate.newLatLngZoom(_center, 17.0),
              );
            });
          }
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      //location = null;
    }
  }
}
