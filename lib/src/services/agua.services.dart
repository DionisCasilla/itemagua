class AguaProvider {
  getSucursalesList() {
    // try {
    //   final Uri urlLogin = Uri.parse("${prefs.baseUrl}api/service");

    //   final requestData = await http.get(
    //     urlLogin,
    //     headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Connection': 'keep-alive', 'Authorization': prefs.uToken},
    //   );

    //   final decodedData = json.decode(requestData.body);
    //   // final AppointmentServiceModel dataService = AppointmentServiceModel.fromJson(decodedData);

    //   if (dataService.success!) {
    //     return dataService;
    //   } else {
    //     return AppointmentServiceModel();
    //   }

    //   // return AppointmentServiceModel();
    // } on TimeoutException catch (e) {

    //   // return AppointmentServiceModel();
    // } on SocketException catch (e) {
    //   //alertApp(contextSA, AlertAppModel(title: "Error", message: e.message));
    //   // return AppointmentServiceModel();
    // } catch (e) {
    //   //alertApp(contextSA, AlertAppModel(title: "Error", message: e.toString()));
    //   // return AppointmentServiceModel();
    // }
  }
}
