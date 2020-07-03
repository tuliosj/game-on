import 'package:flutter/material.dart';
import 'package:game_on/main.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:game_on/screens/blackHole/blackHole.dart';

class BlackHoleScreen extends StatelessWidget {
  final blackHole = getIt.get<BlackHole>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Black Hole'),
        ),
        body: Container(
          color: Colors.grey[700],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder(
                    stream: blackHole.resetExtended$,
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      return FloatingActionButton.extended(
                        isExtended: snap.data is bool && snap.data,
                        onPressed: () => blackHole.reset(),
                        backgroundColor: Colors.grey[900],
                        label: snap.data is bool && snap.data
                            ? Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.delete_forever),
                                  ),
                                  Text("Reset Board?"),
                                ],
                              )
                            : Icon(Icons.delete_forever),
                        tooltip: 'Reset this board',
                        heroTag: 'reset',
                      );
                    },
                  ),
                  Row(
                    children: <Widget>[
                      FloatingActionButton.extended(
                        onPressed: () => blackHole.infoDialog(context),
                        backgroundColor: Colors.blue[400],
                        icon: Icon(Icons.info),
                        label: Text('How to Play'),
                        tooltip: 'How to Play',
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder(
                        stream: blackHole.board$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          return Column(
                            children: <Widget>[
                              for (var i = 0; i < 6; i++)
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (var j = ((i + 1) * i / 2).round();
                                          j <= ((i + 1) * i / 2).round() + i;
                                          j++)
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              blackHole.color(j);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              margin: EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey[200],
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color:
                                                    !(snap.data is List<int>) ||
                                                            snap.data[j] == 0
                                                        ? Colors.grey[700]
                                                        : (snap.data[j] > 0
                                                            ? Colors.red[400]
                                                            : Colors.blue[400]),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  snap.data is List<int> &&
                                                          snap.data[j] != 0
                                                      ? Text(
                                                          snap.data[j]
                                                              .abs()
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white))
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                    ]),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[200],
          child: Container(
              height: 50.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                      stream: blackHole.order$,
                      builder: (BuildContext context, AsyncSnapshot turnSnap) {
                        return StreamBuilder(
                            stream: blackHole.winner$,
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              return snap.data == ''
                                  ? Text(
                                      turnSnap.data is bool && turnSnap.data
                                          ? 'Red\'s turn!'
                                          : 'Blue\'s turn!',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      '${snap.data} wins!',
                                      style: TextStyle(fontSize: 20),
                                    );
                            });
                      }),
                ],
              )),
        ));
  }
}
