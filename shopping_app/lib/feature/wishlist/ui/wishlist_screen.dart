import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fsearch/fsearch.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:shopping_app/feature/home/home.dart';
import 'package:shopping_app/resources/R.dart';
import 'package:shopping_app/route/route_constants.dart';
import 'package:shopping_app/widget/appbar.dart';
import 'package:shopping_app/feature/discover/bloc/discover_bloc.dart';
import 'package:shopping_app/feature/discover/model/product.dart';

class Wishlist extends StatefulWidget {
  HomeScreenState home;

  Wishlist(this.home, {Key key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  double width;
  double height;
  final formatCurrency = NumberFormat.currency(symbol: '', decimalDigits: 3);
  FSearchController searchController;

  @override
  void initState() {
    searchController = FSearchController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.only(top: 20.00),
            child: Center(
              child: FSearch(
                controller: searchController,
                height: 50.0,
                onSearch: (value) {
                  context
                      .bloc<DiscoverBloc>()
                      .add(LoadingWishlistEvent(query: value));
                },
                backgroundColor: Colors.black12,
                style: TextStyle(
                    fontSize: 24.0, height: 1.0, color: Colors.black45),
                margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 9.0),
                padding: EdgeInsets.only(
                    left: 6.0, right: 6.0, top: 3.0, bottom: 10.0),
                prefixes: [
                  const SizedBox(width: 6.0),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Icon(
                      Icons.search,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 3.0)
                ],
              ),
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 6,),
          Expanded(child: BlocBuilder<DiscoverBloc, DiscoverState>(
            builder: (context, state) {
              if (state is WishlistLoadFinished) {
                var listProduct = state.products;
                return GridView.builder(
                  itemCount: listProduct.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var product = listProduct[index];
                    return _buildCardProduct(product);
                  },
                );
              }

              return Container();
            },
          ))
        ],
      ),
    );
  }

  Widget _buildCardProduct(Product product) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
          context, RouteConstant.productDetailsRoute,
          arguments: ScreenArguments(
            product: product,
            home: widget.home
          )),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        child: Container(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  product.title,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 12),
                child: Text(
                  "${formatCurrency.format(double.parse(product.price))} JD",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
