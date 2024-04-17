import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importa el paquete de CarouselSlider
import 'package:registro/reservar/reservar.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore

class Categoria extends StatefulWidget {
  const Categoria({Key? key}) : super(key: key);

  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instancia de Firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                buildContainer(
                  imageUrls: [
                    'images/sencilla1.jpg',
                    'images/sencilla2 (2).jpg',
                    'images/sencilla2.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Sencilla',
                  price: 'HNL 1300',
                ),
                buildContainer(
                  imageUrls: [
                    'images/pareja1.jpg',
                    'images/pareja3.jpg',
                    'images/pareja4.jpg',
                    'images/pareja22.jpg',
                    'images/bp11.jpg',
                  ],
                  title: 'Pareja',
                  price: 'HNL 1700',
                ),
                buildContainer(
                  imageUrls: [
                    'images/d2.jpg',
                    'images/d4.jpg',
                    'images/d5.jpg',
                  ],
                  title: 'Doble',
                  price: 'HNL 1850',
                ),
                buildContainer(
                  imageUrls: [
                    'images/t1.jpg',
                    'images/t2.jpg',
                    'images/t3.jpg',
                    'images/t4.jpg',
                    'images/t33.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Triple',
                  price: 'HNL 2650',
                ),
                buildContainer(
                  imageUrls: [
                    'images/suit1p1.jpg',
                    'images/suit1p2.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Suite Junior (1 Persona)',
                  price: 'HNL 1450',
                ),
                buildContainer(
                  imageUrls: [
                    'images/suit2p1.jpg',
                    'images/suit2p11.jpg',
                    'images/suit2p3.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Suite Junior (2 Personas)',
                  price: 'HNL 1800',
                ),
                buildContainer(
                  imageUrls: [
                    'images/p2.jpg',
                    'images/p3.jpg',
                    'images/p4.jpg',
                    'images/p22.jpg',
                    'images/b1.jpg',
                  ],
                  title: 'Suite Principal',
                  price: 'HNL 2100',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer(
      {required List<String> imageUrls,
      required String title,
      required String price}) {
    TextEditingController priceController = TextEditingController(text: price);

    return Container(
      width: 380,
      height: 458,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 9,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 0),
          CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 260,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 350,
            height: 33,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Color(0xFFE6B800),
            thickness: 2,
            height: 20,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            width: 350,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.paid_outlined,
                  color: Colors.green,
                  size: 30.0,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ingrese el precio',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 350,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(
                  color: const Color.fromARGB(255, 254, 255, 255),
                  width: 0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 147, 153, 155).withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                // Acción al presionar el botón
                print('Precio actualizado: ${priceController.text}');
                await actualizarPrecioFirestore(title, priceController.text);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFE6B800)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                ),
              ),
              child: Text(
                'Actualizar Precio',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Future<void> actualizarPrecioFirestore(
      String nombreCategoria, String nuevoPrecio) async {
    var habitacionQuery = await _firestore
        .collection('habitaciones')
        .where('categoria', isEqualTo: nombreCategoria)
        .get();

    if (habitacionQuery.docs.isNotEmpty) {
      var habitacionDoc = habitacionQuery.docs.first;
      var habitacionId = habitacionDoc.id;

      await _firestore
          .collection('habitaciones')
          .doc(habitacionId)
          .update({'precio': nuevoPrecio});

      print('Precio actualizado en Firestore: $nuevoPrecio');
    } else {
      print('No se encontró la habitación en la base de datos.');
      // Manejo de errores, puedes mostrar un mensaje al usuario si lo deseas
    }
  }
}
