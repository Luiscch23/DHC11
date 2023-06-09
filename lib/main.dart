import 'package:flutter/material.dart';

import 'package:temp/widget/grafica.dart';
import 'package:flutter/material.dart';
import 'services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider()..fetchData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, snapshot, _) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Temperaturaaaaaa'),
          ),
          body: ListView(
            children: [
              Consumer<DataProvider>(builder: (context, snapshot, _) {
                return Container(
                  height: 300,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: buildChart(snapshot.data),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 25,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '°C ' + snapshot.temp.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              snapshot.fetchData();
              // Lógica cuando se presiona el botón flotante
              print('¡Se presionó el botón flotante!eee');
            },
            child: Icon(Icons.refresh),
          ),
        ),
      );
    });
  }
}
//ssh-keygen -t rsa -b 4096 -C "l_carreon@uadec.edu.mx"
