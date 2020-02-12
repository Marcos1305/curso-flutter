import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    CartModel.of(context).updatePrices();
    Widget _buildContent() {
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  cartProduct.productData.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Text(
                  "Tamanho: ${cartProduct.size}",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "R\$: ${cartProduct.productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Theme.of(context).primaryColor,
                      onPressed: cartProduct.quantity > 1
                          ? () {
                              CartModel.of(context).decProduct(cartProduct);
                            }
                          : null,
                    ),
                    Text(cartProduct.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        CartModel.of(context).incProduct(cartProduct);
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                      child: Text("Remover"),
                      textColor: Colors.grey[500],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: cartProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection('products')
                    .document(cartProduct.category)
                    .collection('items')
                    .document(cartProduct.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.productData =
                        ProductData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent());
  }
}