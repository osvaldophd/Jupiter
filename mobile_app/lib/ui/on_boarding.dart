import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:mobile_app/ui/login_page.dart';
import 'package:mobile_app/util/constantes.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final pages = [
    PageViewModel(
        pageColor: Colors.blue, 
        bubble: Image.asset('assets/images/onboarding1.png'),
        body: Text(
          'Aqui vai algum texto básico sobre uma funcionalidade do app.',
        ),
        title: Text(
          'Boleia',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MontserratLight', fontWeight: FontWeight.w400, color: Colors.white, fontSize: 32),
        bodyTextStyle: TextStyle(fontFamily: 'MontserratLight', fontWeight: FontWeight.w300, color: Colors.white, fontSize: 24),
        mainImage: Image.asset(
          'assets/images/onboarding1.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.red,
      iconImageAssetPath: 'assets/images/onboarding2.png',
      body: Text(
          'Aqui vai algum texto básico sobre uma funcionalidade do app.',
      ),
      title: Text('Clima'),
      mainImage: Image.asset(
        'assets/images/onboarding2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MontserratLight', fontWeight: FontWeight.w400, color: Colors.white, fontSize: 32),
        bodyTextStyle: TextStyle(fontFamily: 'MontserratLight', fontWeight: FontWeight.w300, color: Colors.white, fontSize: 24),
    ),
    PageViewModel(
      pageColor: colorText,
      iconImageAssetPath: 'assets/images/onboarding3.png',
      body: Text(
          'Aqui vai algum texto básico sobre uma funcionalidade do app.',
      ),
      title: Text('Contactos'),
      mainImage: Image.asset(
        'assets/images/onboarding3.png', 
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MontserratLight', fontWeight: FontWeight.w400, color: Colors.white, fontSize: 32),
        bodyTextStyle: TextStyle(fontFamily: 'MontserratLight', fontWeight: FontWeight.w300, color: Colors.white, fontSize: 24),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          columnMainAxisAlignment: MainAxisAlignment.spaceBetween,
          pageButtonTextSize: 14.0,
          showNextButton: false,
          showBackButton: false,
          showSkipButton: true,
          doneText: Text("Continuar"),
          nextText: Text("Seguinte"),
          backText: Text("Anterior"),
          skipText: Text("Pular"),
          onTapSkipButton: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
    );
  }
}
