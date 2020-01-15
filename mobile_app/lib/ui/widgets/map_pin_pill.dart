import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/ui/widgets/dialog_call_van.dart';
import 'package:mobile_app/util/constantes.dart';

class MapPinPillComponent extends StatefulWidget {

  double pinPillPosition;
  PinInformation currentlySelectedPin;

  MapPinPillComponent({ this.pinPillPosition, this.currentlySelectedPin});

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {

  final VanBloc _vanBloc = BlocProvider.getBloc<VanBloc>();

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(
        bottom: widget.pinPillPosition,
        right: 0,
        left: 0,
        duration: Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50, height: 50,
                    margin: EdgeInsets.only(left: 10),
                    child: ClipOval(
                      child: widget.currentlySelectedPin.avatarPath == '' ?
                      Image.network(
                      "${Constantes.BASE_URL_IMAGE}/uploads/vans/default.jpg", 
                      fit: BoxFit.cover ) :
                      Image.network(
                      "${Constantes.BASE_URL_IMAGE}${widget.currentlySelectedPin.avatarPath}", 
                      fit: BoxFit.cover )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[ 
                          Text(widget.currentlySelectedPin.title, style: TextStyle(color: widget.currentlySelectedPin.labelColor)),
                          Text(widget.currentlySelectedPin.description, style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text("${widget.currentlySelectedPin.description2} lugares", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: IconButton(
                      icon: Icon(
                        SimpleLineIcons.getIconData("phone"), 
                        color: colorPrimaryAccent,
                        size: 32.0,
                      ),
                      onPressed: () {
                        _vanBloc.getVanMatricula1(widget.currentlySelectedPin.title).then((van){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogCallVan(van.van[0].contactos);
                            });
                        });
                        
                      },
                    ),

                  )
                ],
              ),
            ),
          ),
        );
  }

}