import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderID;

  OrderTile(this.orderID);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            int status = snapshot.data['status'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Código do pedido: ${snapshot.data.documentID}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(_buildProductsText(snapshot.data)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Status do pedido:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildCircle("1", "Preparação", status, 1),
                    Container(height: 1, width: 40, color: Colors.grey[500]),
                    _buildCircle("2", "Transporte", status, 2),
                    Container(height: 1, width: 40, color: Colors.grey[500]),
                    _buildCircle("3", "Entrega", status, 3),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";

    for (LinkedHashMap p in snapshot.data['products']) {
      text +=
          "${p['quantity']}x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n";
    }

    text += "Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}";

    return text;
  }

  Widget _buildCircle(
      String title, String subTitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    } else if (status == thisStatus) {
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}
