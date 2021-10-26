
import 'package:flutter/material.dart';

import 'models/pedido_lista.dart';
import 'models/productos_models.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:Colors.red[50],
        
      ),
      home: MyHomePage(title: 'F o o d S h o p'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = <ProductosModel>[];

  List<ProductosModel> _ListaCarro = <ProductosModel>[];
  @override
  void initState() {
    super.initState();
    _productosDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50)
          ),
          
        ),
        title:Center(
          child:Text(widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle:FontStyle.italic,
            fontSize: 45,
            foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.white,
          ),
          ), 
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 38,
                  ),
                  if (_ListaCarro.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red[900],
                          foregroundColor: Colors.white,
                          child: Text(
                            _ListaCarro.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          )),
                    )
                ],
              ),
              onTap: (){
                if(_ListaCarro.isNotEmpty)
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>Cart(_ListaCarro))
                  );
              },
            ),
          )
        ],
      ),
      body: _cuadroProductos(),
    );
  }

  GridView _cuadroProductos() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _productosModel.length,
      itemBuilder: (context, index) {
        final String image = _productosModel[index].image;
        var item = _productosModel[index];
        return Card(
          elevation: 4.0,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/img/$image",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text('Precio: US'),
                      Text(
                        '\$${item.price.toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          bottom: 8.0,
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            child: (!_ListaCarro.contains(item))
                                ? Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
                                    size: 38,
                                  )
                                : Icon(
                                    Icons.shopping_cart,
                                    color: Colors.red,
                                    size: 38,
                                  ),
                            onTap: () {
                              setState(() {
                                if (!_ListaCarro.contains(item))
                                  _ListaCarro.add(item);
                                else
                                  _ListaCarro.remove(item);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _productosDb() {
    var list = <ProductosModel>[
      ProductosModel(name: 'Hamburguesa', image: 'hamburguesa.jpg', price: 15),
      ProductosModel(name: 'Banderillas', image: 'banderillas.jpg', price: 20),
      ProductosModel(name: 'Nuggets', image: 'nuggets.jpg', price: 25),
      ProductosModel(name: 'Papas', image: 'papas.jpg', price: 14),
      ProductosModel(name: 'Pizza', image: 'Pizza.jpg', price: 19),
      ProductosModel(name: 'Sushi', image: 'sushi.jpg', price: 13),
      ProductosModel(name: 'Papas', image: 'papas.jpg', price: 14),
      ProductosModel(name: 'Pizza', image: 'Pizza.jpg', price: 19),
      ProductosModel(name: 'Hamburguesa', image: 'hamburguesa.jpg', price: 15),
      ProductosModel(name: 'Banderillas', image: 'banderillas.jpg', price: 20),
    ];

    setState(() {
      _productosModel = list;
    });
  }
}
