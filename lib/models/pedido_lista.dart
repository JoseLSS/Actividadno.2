import 'dart:js';

import 'package:compras/models/productos_models.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<ProductosModel> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _fistScroll = true;
  bool _enabled = false;

  List<ProductosModel> _cart;
  Container pagoTotal(List<ProductosModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70.0,
      width: 400,
      color: Colors.red[700],
      child: Row(children: [
        Text(
          'Total: \$${valorTotal(_cart)}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
              
        )
      ]),
    );
  }

  String valorTotal(List<ProductosModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total + listaProductos[i].price * listaProductos[i].quantity;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50)
          ),
          
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant_menu,color: Colors.white,),
            onPressed: null,
            color: Colors.black,
          )
        ],
        title: Text(
          'Detalle',
          style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _fistScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _fistScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final String imagen = _cart[index].image;
                  var item = _cart[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    "assets/img/$imagen",
                                    fit: BoxFit.contain,
                                  ),
                                )),
                                Column(
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )),
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  _removeProduct(index);
                                                  valorTotal(_cart);
                                                },
                                                color: Colors.yellow,
                                              ),
                                              Text(
                                                '${_cart[index].quantity}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  _addProduct(index);
                                                  valorTotal(_cart);
                                                },
                                                color: Colors.yellow,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 38.0,
                                ),
                                Text(
                                  '\$${item.price.toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.purple,
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  _addProduct(int index){
    setState(() {
      _cart[index].quantity++;
    });
  }
  _removeProduct(int index){
    setState(() {
      _cart[index].quantity--;
    });
  }
}
