import 'package:flutter/material.dart';
import 'package:mobile_app/util/constantes.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: colorPrimary,
      ),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 30),
          Image.asset("assets/images/fee.png"),
          SizedBox(height: 40),
          Text("O que achou do BOLEIA?", style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          Text("Envie-nos a sua sugestão, sugira melhorias, reporte erros. Sua opinião é importante para nós.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorBackground,
              borderRadius: BorderRadius.circular(30)
            ),
            child: TextField(
              maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Deixe sua opinião aqui 🙂",
                hintStyle: TextStyle(color: colorText)
              ),
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: colorBackground, 
                  ),
                  child: Center(
                    child: Text(
                      "Enviar",
                      style: TextStyle(
                        fontSize: 20,
                        color: colorPrimaryAccent, 
                        fontFamily: 'MontserratBold'
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}