import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/escala_dia_model.dart';
import 'package:mobile_app/model/escala_funcionario_model.dart';
import 'package:mobile_app/model/funcionario_model.dart';
import 'package:mobile_app/ui/widgets/dialog_menu_motorista.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {

  DateTime _currentDate;
  final EscalaFuncionarioBloc _funcionarioEscalaBloc = BlocProvider.getBloc<EscalaFuncionarioBloc>();
  final FuncionarioBloc _funcionarioBloc = BlocProvider.getBloc<FuncionarioBloc>();
  final EscalaDiaBloc _escalaDiaBloc = BlocProvider.getBloc<EscalaDiaBloc>();
  List<Funcionario> listaFuncionariosEscalados;

  StreamController<List<Funcionario>> _controllerFunEscalados = 
              StreamController<List<Funcionario>>.broadcast();
  Stream<List<Funcionario>> get outEscalaFuncionario => _controllerFunEscalados.stream;

  @override
  void initState() {
    super.initState();
    listaFuncionariosEscalados = [];
    _currentDate = DateTime.now();
    _escalaDiaBloc.getEscalaDia(_currentDate.day);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerFunEscalados.close();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        Container(
          height: 450.0,
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(color: Colors.yellow, offset: Offset(5.0, 5.0))
            // ],
            color: colorBackground,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          ),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              _escalaDiaBloc.getEscalaDia(date.day);
              this.setState(() => _currentDate = date);
            },
            weekendTextStyle: TextStyle(
              color: colorPrimaryAccent,
            ),
            locale: 'pt',
            thisMonthDayBorderColor: colorPrimaryAccent,
            selectedDayBorderColor: colorPrimaryAccent,
            selectedDayButtonColor: colorPrimaryAccent,
            iconColor: colorPrimaryAccent,
            headerTextStyle: TextStyle(color: colorPrimaryAccent, fontSize: 18),
            pageScrollPhysics: ClampingScrollPhysics(),
            customDayBuilder: ( 
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime day,
            ) {
                // if (day.day == 15) {
                //   return Center(
                //     child: Icon(Icons.local_airport),
                //   );
                // } else {
                //   return null;
                // }
            },
            weekFormat: false,
            height: 420.0,
            selectedDateTime: _currentDate,
          ),
        ),

        //------------------------------Escala List Content--------------------------
        SizedBox(height: 10,),

          StreamBuilder<EscalaDiaModel>(
            stream: _escalaDiaBloc.outEscalaDia,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return buildEscala(snapshot.data.data.funcionarioEscala);
              } else if(_escalaDiaBloc.previousEscalaDia != null){
                  return buildEscala(_escalaDiaBloc.previousEscalaDia.data.funcionarioEscala);
              } else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
          ),

        SizedBox(height: 50,),

      ],
    );
  }

  Widget buildEscala(List<FuncionarioEscala> listaEscala ){
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: listaEscala.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index)  {
        return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            leading: CircleAvatar(
              backgroundImage: NetworkImage("${Constantes.BASE_URL_IMAGE}${listaEscala[index].funcionario.imagem}", 
            ),
            ),
            trailing: Icon(SimpleLineIcons.getIconData("star")),
            title: Text(
              listaEscala[index].funcionario.nome, 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text("Nacionalidade: ${listaEscala[index].funcionario.nacionalidade}\nGenero:${listaEscala[index].funcionario.genero == 'M' ? 'Masculino' : 'Feminino'}"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogMenuMotorista(listaEscala[index].funcionario.contactos);
                });
              
            },
          );
      },
    );
  }

  getEscalaDiaSelecionado(DateTime data){
    if(_funcionarioEscalaBloc.previousEscalaFuncionarios != null ){
      EscalaFuncionarioModel escala = _funcionarioEscalaBloc.previousEscalaFuncionarios;
      List<Funcionario> listaFunSel = [];
      escala.funcionarioEscala.forEach((f) {
        if(f.escala.ano == data.year && f.escala.mesId == data.month && f.dia == data.day){
          listaFunSel.add(
            _funcionarioBloc.previousFuncionarios.data.funcionarios
              .singleWhere((x) => x.id == f.funcionario.id)
          );
        }
      });
    }
  }

}