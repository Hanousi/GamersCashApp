import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:shopping_app/feature/home/home.dart';
import 'package:shopping_app/resources/R.dart';
import 'package:shopping_app/resources/resources.dart';
import 'package:shopping_app/route/route_constants.dart';
import '../discover/model/product.dart';
import 'package:intl/intl.dart';

import 'bloc/collection_bloc.dart';

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

  Widget _buildList() {
    if (widget.listProduct.isNotEmpty) {
      return GridView.builder(
        itemCount: widget.listProduct.length ?? 0,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var product = widget.listProduct[index];
          return _buildCardProduct(product);
        },
      );
    } else {
      context
          .bloc<CollectionBloc>()
          .add(LoadingCollectionEvent(collection: widget.categoryName));

      return BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          List<Product> products = [];

          if (state is CollectionFinished) {
            products = state.products;

            return GridView.builder(
              itemCount: products.length ?? 0,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                var product = products[index];
                return _buildCardProduct(product);
              },
            );
          } else if (state is StartCollectionLoad) {
            return Padding(
              padding: EdgeInsets.all(150),
              child: HeartbeatProgressIndicator(
                child: Icon(Icons.search),
              ),
            );
          }

          return Row(
            children: [],
          );
        },
      );
    }
  }

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
                style: Theme.of(context).textTheme.headline2,
              )),
          Expanded(
            child: _buildList(),
          )
        ],
      ),
    );
  }

  Widget _buildCardProduct(Product product) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
          context, RouteConstant.productDetailsRoute,
          arguments: ScreenArguments(product: product, home: widget.home, isFromSale: true)),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Image.network(
                                product.images[0].originalSource,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Text(
                        product.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    Row(
                      children: [
                        product.compareAtPrice != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 12),
                                child: Text(
                                  '${product.compareAtPrice} JD',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              )
                            : Container(),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 16, bottom: 12),
                            child: Text(
                              "${formatCurrency.format(double.parse(product.price))} JD",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              !product.outOfStock
                  ? Align(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth * 0.6,
                            height: constraints.maxHeight * 0.15,
                            color: AppColors.indianRed,
                            child: Center(
                              child: RotatedBox(
                                quarterTurns: 0,
                                child: Text(
                                  'إنتهى من المخزن',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      alignment: Alignment.topLeft,
                    )
                  : Container(),
            ],
          )),
    );
  }
}
