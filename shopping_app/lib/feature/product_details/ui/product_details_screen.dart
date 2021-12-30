import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/home/home.dart';
import 'package:shopping_app/feature/product_details/bloc/product_details_bloc.dart';
import 'package:shopping_app/resources/app_data.dart';
import 'package:shopping_app/resources/app_theme.dart';
import 'package:shopping_app/resources/colors.dart';
import 'package:shopping_app/route/route_constants.dart';
import 'package:shopping_app/widget/bottom_dialog.dart';
import 'package:shopping_app/widget/loader_wiget.dart';

import 'popup_desc_details.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  HomeScreenState home;
  bool isFromSale = false;
  bool isFromPrize = false;

  ProductDetailsScreen(
      {Key key, this.product, this.home, this.isFromSale, this.isFromPrize})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final formatCurrency = NumberFormat.currency(symbol: '', decimalDigits: 3);
  var _isSelectedSize = false;
  var isSubscribed = false;
  var _currentIndexSize = 0;

  Product product;
  String currentImage;

  var _isAddedToBag = false;

  double width;

  Future<void> _showModal() async {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _numberController = TextEditingController();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('ادخل المعلومات للاشتراك في المسابقة'),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'الاسم',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'البريد الاكتروني',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _numberController,
                          decoration: InputDecoration(
                            labelText: 'رقم الهاتف',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            // Or with variable in the class
                            onPressed: AppData.hasSubscribed | isSubscribed
                                ? null
                                : () async {
                                    Navigator.pop(context);

                                    await _sendEmail(
                                        _nameController.text,
                                        _emailController.text,
                                        _numberController.text);
                                    _changeState();
                                  },
                            child: Text('اشتراك'),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        });
  }

  _sendEmail(String name, String email, String number) async {
    String username = 'gamerscashprizes@gmail.com';
    String password = 'Malik12345';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'GamersCash')
      ..recipients.add('gamerscashprizes@gmail.com')
      ..subject = name
      ..text = 'Email: ${email}, Number: ${number}';

    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      print(e);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void _changeState() {
    setState(() {
      AppData.hasSubscribed = true;
      isSubscribed = true;
    });
  }

  @override
  void initState() {
    super.initState();
    product = widget.product;
    currentImage = product.images[0].originalSource;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Scaffold(
          appBar: product == null
              ? AppBar(
                  backgroundColor: Colors.white38,
                )
              : _toolbar(),
          body: product == null
              ? LoaderPage()
              : Stack(
                  children: [_contentBody(), _buttonAddToBag()],
                ),
        ));
  }

  Widget _contentBody() {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: _getColor(product.productType)),
                child: Center(
                    child: Container(
                  child: Image.network(
                    currentImage,
                    width: width,
                    fit: BoxFit.fill,
                  ),
                ))),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(height: 100, child: listImageDetails(product.images)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Container(
            height: 2,
            color: Colors.grey[300],
          ),
        ),
        bodyContentDetails()
      ],
    );
  }

  Widget _toolbar() {
    return AppBar(
      backgroundColor: _getColor(product.productType),
      elevation: 0,
      title: Text(
        product.productType,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bodyContentDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.64,
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    product.compareAtPrice != null
                        ? Text(
                            '${formatCurrency.format(double.parse(product.compareAtPrice)) + ' JD'}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Container(),
                    Text(
                      '${formatCurrency.format(double.parse(product.price))} JD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            product.description,
            style: TextStyle(color: Colors.black54),
            maxLines: 5,
          ),
          SizedBox(
            height: 20,
          ),
          product.description != ''
              ? InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      elevation: 30,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: BottomDialog(
                          title: product.title,
                          child: Text('${product.description}'),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'المزيد من التفاصيل',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget listImageDetails(List<ShopifyImage> images) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        String image = images[index].originalSource;
        return GestureDetector(
            onTap: () {
              setState(() {
                currentImage = image;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6.0),
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.network(
                  image,
                ),
              ),
            ));
      },
    );
  }

  Widget listSize(List<double> sizes) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: sizes.length,
      itemBuilder: (context, index) {
        double size = sizes[index];
        _isSelectedSize = _currentIndexSize == index;
        return GestureDetector(
          onTap: () => onSelectedSize(index, size),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                color: _isSelectedSize ? Colors.black : Colors.white,
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Text(
                    "$size",
                    style: TextStyle(
                        color: _isSelectedSize ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget _buttonAddToBag() {
    return BlocListener(
      bloc: context.bloc<ProductDetailsBloc>(),
      listener: (context, state) {
        if (state is AddProductToBagFinished) {
          if (_isAddedToBag) {
            Navigator.pushNamed(context, RouteConstant.cart);
          }
          setState(() {
            _isAddedToBag = true;
          });
        }
      },
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            width: double.infinity,
            child: widget.home != null
                ? RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    onPressed: () => !product.outOfStock
                        ? null
                        : widget.isFromPrize
                            ? _showModal()
                            : _isAddedToBag
                                ? goToCart()
                                : addProductToCart(),
                    color: _isAddedToBag
                        ? AppColors.grey
                        : _getColor(product.productType),
                    child: Text(
                      !product.outOfStock
                          ? 'إنتهى من المخزن'
                          : widget.isFromPrize
                              ? 'اضغط هنا للاشتراك'
                              : _isAddedToBag
                                  ? 'اذهب إلى السلة'
                                  : 'أضف إلى السلة',
                      style: whiteText,
                    ))
                : Container(),
          )),
    );
  }

  onSelectedSize(int index, double size) {
    setState(() {
      _currentIndexSize = index;
    });
  }

  addProductToCart() {
    BlocProvider.of<ProductDetailsBloc>(context).add(AddProductToCart(product));
  }

  goToCart() {
    Navigator.pop(context);
    if (widget.isFromSale) {
      Navigator.pop(context);
    }
    widget.home.routeTo(2);
  }

  addToWishlistClick() {
    context.bloc<ProductDetailsBloc>().add(AddToWishlistEvent(product));
  }

  Color _getColor(String productType) {
    switch (productType) {
      case 'PC':
        return Colors.black;
      case 'PlayStation':
        return Colors.blueAccent;
      case 'Xbox':
        return Colors.green;
      case 'Nintendo':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
