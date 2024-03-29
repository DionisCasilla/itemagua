import 'package:aguapp/src/constants/AppImages.dart';
import 'package:aguapp/src/constants/Colors.dart';
import 'package:aguapp/src/page/orders/orderspage.dart';
// import 'package:aguapp/src/services/location.services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  // final geo = Geolocation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getLocation();
  }

  // getLocation() async {
  //   await geo.determinePosition();
  // }

  var pages = const [Text("Página 1"), Text("Página 2"), OrdersPage(), Text("Página 4"), Text("Página 5")];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1ff8fa,
      appBar: AppBar(
          backgroundColor: colore2f6ff,
          elevation: 0,
          centerTitle: true,
          title: Text(
            _currentPage != 2 ? "Inicio" : "Localidades",
            style: const TextStyle(color: color3db8e6, fontWeight: FontWeight.w600),
          )),
      body: Center(
        child: pages[_currentPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        backgroundColor: Colors.blueAccent.shade200,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toc_sharp),
            label: 'Ordenes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Mas',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Novedades",
              style: TextStyle(color: color2e55a5, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.red,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .16,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Catalogo",
              style: TextStyle(color: color2e55a5, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 140,
                        width: 140,
                        //  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade100, borderRadius: BorderRadius.circular(10)),
                                // color: Colors.blue,
                                height: 60,
                                width: double.infinity,
                              ),
                            ),
                            Image.asset(AppImages.botellon, width: 140),
                            const Align(alignment: Alignment.bottomCenter, child: Text("Botellon")),
                          ],
                        )),
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

/*
Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(color: Colors.white),
            ),

*/

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    final path = Path();
    path.lineTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width * .25, size.height * 0.2, size.width, size.height * 0.1);
    path.quadraticBezierTo(size.width * .25, size.height * 0.2, size.width, size.height * 0.2);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;

  // @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}
