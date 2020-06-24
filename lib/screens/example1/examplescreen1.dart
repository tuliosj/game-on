import 'package:flutter/material.dart';
import 'components/body.dart';
import 'example-bloc.dart';
import '../../bloc/bloc-prov.dart';

class ExScreen1 extends StatefulWidget {
  @override
  _ExScreen1State createState() => _ExScreen1State();
}

class _ExScreen1State extends State<ExScreen1> {
  ExampleBloc exampleBloc;

  @override
  void initState() {
    super.initState();

    exampleBloc = ExampleBloc();
  }

  @override
  void dispose() {
    exampleBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: exampleBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("First Screen"),
        ),
        body: Body(),
      ),
    );
  }
}
