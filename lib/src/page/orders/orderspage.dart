import 'package:aguapp/src/page/orders/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<dynamic> _elements = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _makeRequest();
  }

  void _makeRequest() async {
    final Uri url = Uri.parse("http://192.168.42.246:8001/agua/sucursales");

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _elements = jsonResponse['result'];
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de elementos')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Buscar elementos'),
              onChanged: (value) {
                // TODO: Implementar la lógica de búsqueda
                print(_searchController);
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _elements.length,
                    itemBuilder: (BuildContext context, int index) {
                      final element = _elements[index];
                      return ListTile(
                        leading:
                            Text('ID: ${element['ContactoID'].toString()}'),
                        title: Container(
                          padding: EdgeInsets.all(5.0),
                          // decoration: BoxDecoration(

                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  'Cliente: ${element['ContactoTexto'].toString()}'),
                            ],
                          ),
                        ),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  'Direccion: ${element['ContactoDireccion'].toString()}'),
                              Text(
                                  'Location 1: ${element['ContactoLocation'].toString()}'),
                              Text(
                                  'Location 2: ${element['ContactoLocation2 '].toString()}'),
                            ]),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(element: element),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
