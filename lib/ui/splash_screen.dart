
import 'package:flutter/material.dart';
import 'package:freecoursediscount/ui/home_screen.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool intVar = true;
  double devwidth, devheight;

  @override
  void initState() {
    initle();
  }

  @override
  Widget build(BuildContext context) {
    devwidth = MediaQuery.of(context).size.width;
    devheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Image.network("https://c.ndtvimg.com/2020-02/nkgqpuhg_rrr-film-_625x300_05_February_20.jpg")),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  void initle() {



    Future.delayed(const Duration(seconds: 1), () async {
    Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return HomePage();

          }));

        },
      );
    }


  initbe() {

  }


}