import 'dart:async';

import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MiPagina(),
    );
  }
}

class MiPagina extends StatefulWidget {

  @override
  _MiPaginaState createState() => _MiPaginaState();
}

class _MiPaginaState extends State<MiPagina> {

  final colorStream = new StreamController<Color>();

  int counter = -1;
  final List<Color> colorList = [
    Colors.blue,
    Colors.yellowAccent,
    Colors.green,
    Colors.redAccent
  ];



//es uena practica poner el "dispose" pra que cuando ya no se use el Stream se de por terminado
  @override
  void dispose() {
    // TODO: implement dispose
    colorStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practica de StreamBuilder'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: colorStream.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

            if(!snapshot.hasData){
              return LoadingWidget();
              
            }
            if (snapshot.connectionState == ConnectionState.done){
              return Text("Fin del Stream :(");
            }

            return Container(
              height: 150.0,
              width: 150.0,
              color: snapshot.data,
              child: Text("Color numero: "),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens),
        onPressed: (){

          counter++;
          if (counter < colorList.length){
            colorStream.sink.add(colorList[counter]);
          }else{
            colorStream.close();
          }

        }
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Esperando clicks"),
        SizedBox(height : 20),
        CircularProgressIndicator()
      ],
    );
  }
}