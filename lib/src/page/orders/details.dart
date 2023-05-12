import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Details extends StatelessWidget {
  final element;

  Details({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(element['ContactoTexto']),
      ),
      body: Container(
        width: double.infinity,
        height: 300,
        child: Column(
          children: [
            Text('ID: ${element['ContactoID']}'),
            Text('Dirección: ${element['ContactoDireccion']}'),
            Text('Location 1: ${element['ContactoLocation']}'),
            Text('Location 2: ${element['ContactoLocation2']}'),
          ],
        ),
      ),
    );
  }
}
