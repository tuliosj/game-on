import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaosVsOrder extends StatefulWidget {
  @override
  _ChaosVsOrderState createState() => _ChaosVsOrderState();
}

class _ChaosVsOrderState extends State<ChaosVsOrder> {
  List<Color> indexes =
      new List<Color>.filled(36, Colors.grey[200], growable: false);

  Color red = Colors.red;
  Color blue = Colors.blue;
  bool ohTurn = true;
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  static var fontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Chaos',
                      style: fontWhite,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ohScore.toString(),
                      style: fontWhite,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Order',
                      style: fontWhite,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      exScore.toString(),
                      style: fontWhite,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 36,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700]),
                          color: indexes[index]),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      ' ',
                      style: fontWhite,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      ' ',
                      style: fontWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
