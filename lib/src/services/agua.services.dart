import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:aguapp/src/constants/Endpoint.dart';

class AguaProvider {
  getSucursalesList({String search = ""}) async {
    try {
      final Uri urlLogin = Uri.parse("${Endpoint.baseUrlDev}sucursales?search=$search");

      final requestData = await http.get(
        urlLogin,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Connection': 'keep-alive'},
      );

      final decodedData = json.decode(requestData.body);
      print(decodedData);
      return decodedData;
    } on TimeoutException catch (e) {
      // return AppointmentServiceModel();
      // print(e);
    } on SocketException catch (e) {
      print(e);
      //alertApp(contextSA, AlertAppModel(title: "Error", message: e.message));
      // return AppointmentServiceModel();
    } catch (e) {
      print(e);
      //alertApp(contextSA, AlertAppModel(title: "Error", message: e.toString()));
      // return AppointmentServiceModel();
    }
  }

  updateLocation(Map sucursal) async {
    try {
      final Uri urlLogin = Uri.parse("${Endpoint.baseUrlDev}sucursales/${sucursal["CLIENTE_ID"]}");
      //print(urlLogin);

      final requestData = await http.put(
        urlLogin,
        body: jsonEncode(sucursal),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Connection': 'keep-alive'},
      );

      final decodedData = json.decode(requestData.body);
      print(decodedData);
      return decodedData;
    } on TimeoutException catch (e) {
      // return AppointmentServiceModel();
      print(e);
    } on SocketException catch (e) {
      print(e);
      //alertApp(contextSA, AlertAppModel(title: "Error", message: e.message));
      // return AppointmentServiceModel();
    } catch (e) {
      print(e);
      //alertApp(contextSA, AlertAppModel(title: "Error", message: e.toString()));
      // return AppointmentServiceModel();
    }
  }
}
