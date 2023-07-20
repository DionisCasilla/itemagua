import 'package:aguapp/src/page/orders/details.dart';
import 'package:aguapp/src/services/agua.services.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final aguaprovider = AguaProvider();
  List<dynamic> _elements = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _makeRequest();
  }

  void _makeRequest({String search = ""}) async {
    setState(() {
      isLoading = true;
    });
    final data = await aguaprovider.getSucursalesList(search: search);

    setState(() {
      _elements = data['result'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Lista de Clientes')),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(controller: _searchController, decoration: const InputDecoration(hintText: 'Buscar elementos'), onChanged: (valor) => _makeRequest(search: valor)),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _elements.length,
                      itemBuilder: (BuildContext context, int index) {
                        final element = _elements[index];
                        return ListTile(
                          leading: Text(element['CLIENTE_ID'].toString()),
                          title: Text(element['CLIENTE_NOMBRE'].toString().trimRight()),
                          subtitle: SizedBox(
                            width: 200,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Direccion: ${element['DIRECCION'].toString()}'),
                              Text('Telefono: ${element['TELEFONO'].toString()}'),
                              // Text('Location 1: ${element['MAP_PIN'].toString()}'),
                              // Text('Location 2: ${element['ContactoLocation2 '].toString()}'),
                            ]),
                          ),
                          trailing: const Icon(Icons.arrow_forward),
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
      ),
    );
  }
}
