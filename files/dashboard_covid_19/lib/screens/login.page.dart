import 'package:dashboard_covid_19/config/palette.dart';
import 'package:dashboard_covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dashboard_covid_19/screens/screens.dart';

class LoginPage extends StatelessWidget {
  void _launchLink(String url) async {
    //Chamada de URL serve para direcionar os cliques para urls

    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {
      print('Não é possível executar o link$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          //espaço ocupado pela logo
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              //campo de e-mail
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              //Campo de senha
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Text(
                  "Recuperar Senha",
                  // textAlign: TextAlign.right,
                ),
                onPressed: () {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //builder: (context) => ResetPasswordPage(),
                  //),
                  //),
                },
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Palette.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      //    Container(
                      //    child: SizedBox(
                      //    child: Image.asset("assets/icone.png"),
                      //    height:10,
                      //    width: 10,
                      // ),
                      //  ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF000080),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Login com Facebook",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      /* Container(
                          child: SizedBox(
                            child: Image.asset("asset/fbicon.png"),
                            height: 10,
                            width: 10,
                          ),
                        ),*/
                    ],
                  ),
                  onPressed: () => _launchLink(
                      'https://www.facebook.com/'), //Permite que o botão seja clicável e direciona url
                ),
              ),
            ),
            SizedBox(
              height: 10, //espaçamento entre os botões
            ),
            Container(
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen(), //direciona para a tela HomeScreen
                    ),
                  );
                },
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}