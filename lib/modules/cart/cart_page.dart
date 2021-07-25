import 'package:carrinho_de_compras/modules/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CartPage extends StatefulWidget {
  final CartController controller;
  CartPage({Key? key, required this.controller}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomSheet: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Total do carrinho:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Observer(builder: (_) {
                    return Text(
                      widget.controller.cartPrice,
                      style: Theme.of(context).textTheme.headline6,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        body: widget.controller.list.isEmpty
            ? Center(child: Text("OPS! Seu carrinho está vazio"))
            : Observer(builder: (_) {
                return DataTable(
                  dataRowHeight: 50,
                  columnSpacing: 10,
                  columns: <DataColumn>[
                    DataColumn(label: Text("PRODUTO")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("QTD")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("UND")),
                    DataColumn(label: Text("PREÇO")),
                  ],
                  rows: widget.controller.list
                      .map(
                        (prod) => DataRow(cells: [
                          DataCell(Text(prod.product.name)),
                          DataCell(
                            IconButton(
                                onPressed: () =>
                                    widget.controller.removeItem(prod.product),
                                icon: Icon(Icons.remove_circle)),
                          ),
                          DataCell(Center(
                            child: Text(
                              '${prod.quantity}',
                              textAlign: TextAlign.right,
                            ),
                          )),
                          DataCell(IconButton(
                              onPressed: () =>
                                  widget.controller.addItem(prod.product),
                              icon: Icon(Icons.add_circle))),
                          DataCell(Text(prod.product.price.toString())),
                          DataCell(Text(prod.totalPrice)),
                        ]),
                      )
                      .toList(),
                );
              }));
  }
}
