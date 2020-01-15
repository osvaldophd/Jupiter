import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/bloc/auth_bloc.dart';
import 'package:mobile_app/ui/menu_container_page.dart';
import 'package:mobile_app/util/constantes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthBloc authBloc = BlocProvider.getBloc<AuthBloc>();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  bool processando = false;
  
  @override
  void initState() {
    super.initState();
    processando = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBackground,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  
                  //SizedBox(height: 50.0,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      Image.asset('assets/images/logo.png',
                        height: MediaQuery.of(context).size.height*0.1
                      ),

                      SizedBox(height: 20,),

                      Text(
                        "Aqui ira a frase de slogan do app Boleia", 
                        textAlign: TextAlign.center, 
                        style: TextStyle(
                          color: colorText, 
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffe0e0e0),
                                blurRadius: 5.0, // has the effect of softening the shadow
                                spreadRadius: 1.0, // has the effect of extending the shadow
                                offset: Offset(
                                  0.0, // horizontal, move right 10
                                  0.0, // vertical, move down 10
                                ),
                              )
                            ],
                          ),
                          child: TextField(
                              controller: txtEmail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Container(
                                  decoration: BoxDecoration(                     
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
                                  ),
                                  child: Icon(Icons.mail_outline, color: colorPrimary)
                                ),
                                hintText: 'Insira o email',
                                hintStyle: TextStyle(color: colorText)
                              ),
                            ),
                        ),

                        SizedBox(height: 15,),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffe0e0e0),
                                blurRadius: 5.0, // has the effect of softening the shadow
                                spreadRadius: 1.0, // has the effect of extending the shadow
                                offset: Offset(
                                  0.0, // horizontal, move right 10
                                  0.0, // vertical, move down 10
                                ),
                              )
                            ],
                          ),
                          child: Center(
                            child: TextField(
                                controller: txtPassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Container(
                                    decoration: BoxDecoration(                     
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
                                    ),
                                    child: Icon(Icons.lock, color: colorPrimary,)
                                  ),
                                  hintText: 'Insira a password',
                                  hintStyle: TextStyle(color: colorText)
                                ), 
                              ),
                          ),
                        ),

                        SizedBox(height: 15,),

                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: colorPrimary, 
                            ),
                            child: Center(
                              child: processando ? CircularProgressIndicator() : 
                              Text(
                                "Entrar",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: colorText, 
                                  fontFamily: 'MontserratBold'
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              processando = true;
                            });
                            login();
                          },
                        ),

                      ],
                    ),
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Ainda não tem conta?", 
                        style: TextStyle(
                          color: colorText, 
                          fontSize: 16,
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          "Cadastra-se", 
                          style: TextStyle(
                            color: colorText, 
                            fontSize: 16,
                            fontFamily: 'MontserratBold',
                          ),
                        ),
                        onPressed: () => {},
                      )
                    ],
                  ),



                ],
            ),
          ),
        ),
    );
  }

  void login(){
    authBloc.login(txtEmail.text, txtPassword.text)..then((user) {
      if (!user.status && user.error != null && user.error.length > 0) {
        Fluttertoast.showToast(
            msg: 'Nome de usuário ou palavra-passe incorrecta',
            fontSize: 18.0,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIos: 1,
            backgroundColor: Colors.black);
      } else if (user.status && user.error == null && user.token != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MenuContainerPage()),
            (Route<dynamic> route) => false);
      }
      setState(() {
        processando = false;
      });
    });
    
  }
}