import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:shopping_app/feature/home/home.dart';
import 'package:shopping_app/resources/R.dart';
import 'package:shopping_app/resources/resources.dart';
import 'package:shopping_app/route/route_constants.dart';
import '../discover/model/product.dart';
import 'package:intl/intl.dart';

class ProductCategoryScreen extends StatefulWidget {
  final List<Product> listProduct;
  final String categoryName;
  final HomeScreenState home;

  ProductCategoryScreen(
      {@required this.listProduct, this.categoryName, this.home});

  @override
  _ProductCategoryScreenState createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final formatCurrency = NumberFormat.currency(symbol: '', decimalDigits: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 28, right: 28, bottom: 16),
              child: Text(
                '${widget.categoryName}',
                style: headingText1,
              )),
          Expanded(
            child: GridView.builder(
              itemCount: widget.listProduct.length ?? 0,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                var product = widget.listProduct[index];
                return _buildCardProduct(product);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardProduct(Product product) {
    return InkWell(
        onTap: () => Navigator.pushNamed(
            context, RouteConstant.productDetailsRoute,
            arguments: ScreenArguments(product: product, home:widget.home, isFromSale: true)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.white,
          child: Container(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        product.images[0].originalSource,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    child: Text(
                      product.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 12),
                    child: Text(
                      "${formatCurrency.format(double.parse(product.price))} JD",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
