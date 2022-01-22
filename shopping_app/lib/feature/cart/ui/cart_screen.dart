import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shopping_app/feature/cart/bloc/cart_bloc.dart';
import 'package:shopping_app/feature/cart/models/cart.dart';
import 'package:shopping_app/feature/cart/models/cart_item.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:shopping_app/resources/app_theme.dart';
import 'package:shopping_app/resources/colors.dart';
import 'package:shopping_app/route/route_constants.dart';
import 'package:shopping_app/widget/alert_dialog.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final formatCurrency = NumberFormat.currency(symbol: '', decimalDigits: 3);

  double width;

  Cart thisCart;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartLoadingEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              Cart cart;
              if (state is CartLoadFinished) {
                cart = state.cart;
                thisCart = state.cart;
              }

              if (cart != null) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 28, right: 28, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'السلة',
                                  style: headingText,
                                ),
                                Text(
                                    ' مجموع ${cart.listCartItem.length} أغراض ')
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cart.listCartItem.length,
                            itemBuilder: (context, index) {
                              print(cart.listCartItem.isEmpty);

                              if (cart.listCartItem.isEmpty) {
                                return Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Cart is Empty',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else {
                                final cartItem = cart.listCartItem[index];
                                return Container(child: _cartItem(cartItem));
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            child: _resultCart(cart.getTotalPrice(), cart))),
                  ],
                );
              }

              return Container();
            },
          )),
    );
  }

  Widget _resultCart(double totalPrice, Cart cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 1,
          color: Colors.grey[300],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${formatCurrency.format(totalPrice)} JD",
                style: boldTextMedium,
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _nextButton(cart)
      ],
    );
  }

  Widget _nextButton(Cart cart) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onPressed: _launchURL,
          color: AppColors.indianRed,
          child: Text(
            'اطلب الان',
            style: whiteText,
          )),
    );
  }

  _launchURL() async {
    await launch(thisCart.url);
  }

  Widget _cartItem(CartItem cartItem) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.productDetailsRoute,
                arguments:
                    ScreenArguments(product: cartItem.product, home: null));
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(24),
                width: 120,
                height: 120,
              ),
              Positioned(
                  right: 0,
                  bottom: 15,
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          cartItem.product.images[0].originalSource,
                          width: 140,
                        )),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  cartItem.product.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${formatCurrency.format(double.parse(cartItem.product.price))} JD',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: OutlineButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          decreaseQuantity(cartItem.product, cartItem),
                      child: const Icon(Icons.remove),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                        width: width * 0.025, child: cartItem.cartQuantity),
                  ),
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: OutlineButton(
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          increaseQuantity(cartItem.product, cartItem),
                      child: Icon(Icons.add),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  increaseQuantity(Product product, CartItem cartItem) {
    setState(() {
      cartItem.cartQuantity = JumpingDotsProgressIndicator(fontSize: 11.3);
    });

    BlocProvider.of<CartBloc>(context).add(IncreaseQuantityCartItem(product));
  }

  decreaseQuantity(Product product, CartItem cartItem) {
    if (cartItem.quantity <= 1) {
      showAlertDialog(
          context,
          "Remove cart items?",
          ""
              "Are you sure you want to remove ${product.title} from the shopping cart",
          () =>
              BlocProvider.of<CartBloc>(context).add(RemoveCartItem(cartItem)));
    } else {
      setState(() {
        cartItem.cartQuantity = JumpingDotsProgressIndicator(fontSize: 11.3);
      });

      BlocProvider.of<CartBloc>(context)
          .add(DecreaseQuantityCartItem(cartItem, cartItem.quantity - 1));
    }
  }
}
