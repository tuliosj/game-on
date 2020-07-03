import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:game_on/main.dart';
import 'package:game_on/screens/orderAndChaos/orderAndChaos.dart';

class OacScreen extends StatelessWidget {
  final oac = getIt.get<OrderAndChaos>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Order and Chaos'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder(
                  stream: oac.resetExtended$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return FloatingActionButton.extended(
                      isExtended: snap.data is bool && snap.data,
                      onPressed: () => oac.reset(),
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
                      onPressed: () => oac.infoDialog(context),
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
                      stream: oac.order$,
                      builder: (BuildContext context, AsyncSnapshot turnSnap) {
                        return StreamBuilder(
                            stream: oac.winner$,
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              return snap.data == ''
                                  ? Text(
                                      turnSnap.data is bool && turnSnap.data
                                          ? 'Order\'s turn!'
                                          : 'Chaos\'s turn!',
                                    )
                                  : Text(
                                      '${snap.data} wins!',
                                    );
                            });
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
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        snap.data is List<Color>
                                            ? (snap.data[index] ==
                                                        Colors.red[200] ||
                                                    snap.data[index] ==
                                                        Colors.blue[200]
                                                ? Icon(Icons.assistant_photo)
                                                : Container())
                                            : Container()
                                      ]),
                                ),
                              );
                            },
                          ),
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
        ),
      ),
      floatingActionButton: StreamBuilder(
        stream: oac.red$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return FloatingActionButton(
            onPressed: () => oac.changePalette(),
            tooltip: 'Change Color',
            backgroundColor: snap.data is bool && snap.data
                ? Colors.red[400]
                : Colors.blue[400],
            child: Icon(Icons.palette),
            heroTag: 'palette',
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
