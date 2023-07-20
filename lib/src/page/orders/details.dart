import 'dart:math';

import 'package:aguapp/src/services/agua.services.dart';
import 'package:aguapp/src/services/location.services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Details extends StatefulWidget {
  final element;

  Details({Key? key, required this.element}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final coord = Geolocation();
  GoogleMapController? mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  LatLng? markerPosition;
  final aguaProvider = AguaProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.element['MAP_PIN'].toString() != "") {
      _add(latitude: double.tryParse(widget.element['MAP_PIN'].toString().split(",")[0]) ?? 0.0, longitude: double.tryParse(widget.element['MAP_PIN'].toString().split(",")[1]) ?? 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.element['CLIENTE_NOMBRE']),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              // width: 300.0,
              // height: 200.0,
              child: GoogleMap(
                myLocationEnabled: true,
                markers: Set<Marker>.of(markers.values),
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                    zoom: widget.element['MAP_PIN'].toString() != "" ? 20.0 : 0.0,
                    target: widget.element['MAP_PIN'].toString() != ""
                        ? LatLng(double.tryParse(widget.element['MAP_PIN'].toString().split(",")[0]) ?? 0.0, double.tryParse(widget.element['MAP_PIN'].toString().split(",")[1]) ?? 0.0)
                        : const LatLng(0.0, 0.0)),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                Column(
                  children: [
                    Text('ID: ${widget.element['CLIENTE_ID']}'),
                    Text('Dirección: ${widget.element['DIRECCION']}'),
                    Text('Coordenadas: ${widget.element['MAP_PIN']}'),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final current = await coord.determinePosition();
                      widget.element['MAP_PIN'] = "${current!.latitude},${current.longitude}";
                      mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            bearing: 0.0,
                            target: LatLng(current.latitude, current.longitude),
                            tilt: 0.0,
                            zoom: 20.0,
                          ),
                        ),
                      );
                      _add(latitude: current.latitude, longitude: current.longitude);
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.blue.shade300, borderRadius: BorderRadius.circular(80)),
                      width: 160,
                      height: 50,
                      child: const Text("Coordenadas", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 100,
                              child: AlertDialog(
                                  elevation: 50,
                                  title: const Text("Alert!!"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('No'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Si'),
                                      onPressed: () async {
                                        showLoaderDialog(context);
                                        final resp = await aguaProvider.updateLocation(widget.element);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                  content: const Text('¿Está seguro que desea guardar la nueva ubicación?')),
                            );
                          });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.green.shade300, borderRadius: BorderRadius.circular(80)),
                      width: 160,
                      height: 50,
                      child: const Text("Guardar", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    setState(() {
      markerPosition = newPosition;
    });
  }

  Future<void> _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        markerPosition = null;
      });
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  void _add({double latitude = 0.0, double longitude = 0.0}) {
    final int markerCount = 0; //markers.length;

    // if (markerCount == 12) {
    //   return;
    // }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          latitude, // + sin(_markerIdCounter * pi / 6.0) / 20.0,
          longitude // + cos(_markerIdCounter * pi / 6.0) / 20.0,
          ),
      //  infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    //  setState(() {
    markers.clear();
    markers[markerId] = marker;
    //});
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = markers[markerId]!.markerId;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!.copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 60,
        child: Column(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 7), child: const Text("Cargando...")),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
