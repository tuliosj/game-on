import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final TextStyle font = GoogleFonts.montserrat(
      textStyle: TextStyle(color: Colors.white, fontSize: 18),
      color: Colors.blue[400]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'GAME ON',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  onPressed: () => Navigator.pushNamed(context, '/oac'),
                  child: Text('Order and Chaos', style: font),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  onPressed: () => Navigator.pushNamed(context, '/blackhole'),
                  child: Text('Black Hole', style: font),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
