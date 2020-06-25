import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:game_on/main.dart';
import 'package:game_on/screens/orderAndChaos/orderAndChaos.dart';

class oacScreen extends StatelessWidget {
  final oac = getIt.get<OrderAndChaos>();

  TextStyle tStyle = TextStyle(color: Colors.white, fontSize: 30);
  TextStyle font = GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.grey[900], fontSize: 24));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[300],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.red[300],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                      spreadRadius: 0.6,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FloatingActionButton(
                            onPressed: () => oac.reset(),
                            backgroundColor: Colors.grey[900],
                            mini: true,
                            child: Icon(Icons.delete_forever)),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Reset Board'),
                      ],
                    ),
                    Text(
                      'Order and Chaos',
                      style: font,
                    ),
                    StreamBuilder(
                        stream: oac.winner$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          return Text(
                            '${snap.data}',
                            style: font,
                          );
                        }),
                    StreamBuilder(
                        stream: oac.board$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: 36,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    oac.color(index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: snap.data is List<Color>
                                          ? snap.data[index]
                                          : Colors.grey[200],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                    StreamBuilder(
                        stream: oac.red$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FloatingActionButton(
                                  onPressed: () => oac.changeColor(),
                                  backgroundColor: snap.data
                                      ? Colors.red[400]
                                      : Colors.blue[400],
                                  child: Icon(Icons.format_paint))
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
