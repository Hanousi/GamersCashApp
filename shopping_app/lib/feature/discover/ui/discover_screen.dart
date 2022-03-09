import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shopping_app/feature/discover/bloc/discover_bloc.dart';
import 'package:shopping_app/feature/discover/bloc/prize_bloc.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/home/home.dart';
import 'package:shopping_app/resources/R.dart';
import 'package:shopping_app/resources/app_data.dart';
import 'package:shopping_app/resources/resources.dart';
import 'package:shopping_app/route/route_constants.dart';
import 'package:shopping_app/widget/appbar.dart';
import 'package:shopping_app/widget/card_product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../route/route_constants.dart';
import '../bloc/discover_bloc.dart';
import '../model/product.dart';

class ScreenArguments {
  final Product product;
  final HomeScreenState home;
  bool isFromSale = false;
  bool isFromPrize = false;

  ScreenArguments({this.product, this.home, this.isFromSale, this.isFromPrize});
}

class DiscoverScreen extends StatefulWidget {
  HomeScreenState home;

  DiscoverScreen(this.home, {Key key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with AutomaticKeepAliveClientMixin<DiscoverScreen> {
  var _isSelectedCategory = false;
  var _currentIndexCategory = 0;

  var _isSelectedProductType = false;
  var _currentIndexProductType = 0;

  String _currentProductType = 'جديد';
  String _currentCategory = 'سماعات';

  double width;
  double height;

  List<Product> listProduct;
  List<Product> allProducts;
  List<Product> onSale;
  Product prizeProduct;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    context.bloc<DiscoverBloc>().add(LoadingDiscoverEvent(
        category: categories[_currentIndexCategory],
        productType: ProductType.values()[_currentIndexProductType]));
    context.bloc<PrizeBloc>().add(LoadingPrizeEvent());
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 24.0,
      fontFamily: 'Horizon',
    );

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: CommonAppBar(title: 'Gamers Cash'),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            _buildCompetition(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: 200,
                child: GridView(
                  padding: EdgeInsets.only(right: 10),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (85 / 100), crossAxisCount: 2),
                  children: [
                    _buildCategoryCard(
                        'New Offers',
                        Colors.redAccent,
                        Image.asset(
                          R.icon.sale,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'PlayStation',
                        Colors.blue,
                        Image.asset(
                          R.icon.playstation,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'XBOX',
                        Colors.green,
                        Image.asset(
                          R.icon.xbox,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Nintendo',
                        Colors.red,
                        Image.asset(
                          R.icon.nintendo,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Computer',
                        Colors.blueGrey,
                        Image.asset(
                          R.icon.computer,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Gift Cards',
                        Colors.teal,
                        Image.asset(
                          R.icon.cards,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Mobile',
                        Colors.lime,
                        Image.asset(
                          R.icon.mobile,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Recording & Streaming',
                        Colors.blueGrey,
                        Image.asset(
                          R.icon.rec,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Headsets',
                        Colors.blueAccent,
                        Image.asset(
                          R.icon.headphone,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Room Design',
                        Colors.lightGreen,
                        Image.asset(
                          R.icon.gameRoom,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'New CDs',
                        Colors.greenAccent,
                        Image.asset(
                          R.icon.newCds,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Used CDs',
                        Colors.cyanAccent,
                        Image.asset(
                          R.icon.usedCds,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Speakers',
                        Colors.orange,
                        Image.asset(
                          R.icon.speakers,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Toys & Wearables',
                        Colors.pink,
                        Image.asset(
                          R.icon.toys,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Keyboards',
                        Colors.deepPurple,
                        Image.asset(
                          R.icon.keyboard,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Cables',
                        Colors.tealAccent,
                        Image.asset(
                          R.icon.cables,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Laptop Spareparts',
                        Colors.yellow,
                        Image.asset(
                          R.icon.spareparts,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Hardware & Software',
                        Colors.grey,
                        Image.asset(
                          R.icon.wrench,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Gaming Devices',
                        Colors.blueGrey,
                        Image.asset(
                          R.icon.consoles,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Lighting Accessories',
                        Colors.purple,
                        Image.asset(
                          R.icon.spotlight,
                          height: 35,
                        )),
                    _buildCategoryCard(
                        'Mouses',
                        Colors.blue,
                        Image.asset(
                          R.icon.mouse,
                          height: 35,
                        )),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Container(height: 40, child: _buildListCategory())),
            Row(
              children: [
                Container(
                    width: width * 0.1,
                    height: height * 0.40,
                    child: _buildListType()),
                Container(
                    width: width * 0.9,
                    height: height * 0.40,
                    child: _buildListProduct()),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 80,
                color: Colors.black,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: GestureDetector(
                          onTap: () async {
                            await _launchURL(
                                'https://www.instagram.com/gamers_cash/');
                          },
                          child: Image.asset(
                            R.icon.instagram,
                            height: 55,
                          )),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: GestureDetector(
                          onTap: () async {
                            await _launchURL(
                                'https://www.facebook.com/Gamers.Cash.jo/');
                          },
                          child: Image.asset(
                            R.icon.facebook,
                            height: 55,
                          )),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: GestureDetector(
                          onTap: () async {
                            await _launchURL(
                                'https://m.youtube.com/channel/UCZGFd9G1hj1PnEFcPuwadfQ');
                          },
                          child: Image.asset(
                            R.icon.youtube,
                            height: 40,
                          )),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: GestureDetector(
                          onTap: () async {
                            await _launchURL(
                                'https://vm.tiktok.com/ZSe87wjdL/');
                          },
                          child: Image.asset(
                            R.icon.tiktok,
                            height: 50,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(R.icon.delivery),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'عروض أسبوعية',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                      icon: Image.asset(
                        R.icon.rightArrow,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteConstant.productCategory, arguments: {
                          "listProduct": onSale,
                          "categoryName": "عروض أسبوعية",
                          "home": widget.home
                        });
                      })
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildSaleList()),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'اذا كان هناك خطأ في التطبيق او عدم معرفة طريقة الطلب يمكنك الاتصال بنا | 0791433878',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildCategoryCard(String text, Color color, Image image) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.productCategory,
              arguments: {
                "listProduct": <Product>[],
                "categoryName": text,
                "home": widget.home
              });
        },
        child: Padding(
            padding: EdgeInsets.only(left: 15, bottom: 8),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: image),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3, left: 2, right: 2),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _buildSaleList() {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        onSale = [];

        if (state is DiscoverLoadFinished) {
          onSale = state.onSale;

          return Column(
            children: [
              Row(
                children: [
                  Flexible(flex: 2, child: _buildCardBottomNew(onSale[0])),
                  Flexible(flex: 2, child: _buildCardBottomNew(onSale[1]))
                ],
              ),
              Row(
                children: [
                  Flexible(flex: 2, child: _buildCardBottomNew(onSale[2])),
                  Flexible(flex: 2, child: _buildCardBottomNew(onSale[3]))
                ],
              ),
            ],
          );
        }

        return Row(
          children: [],
        );
      },
    );
  }

  Widget _buildCompetition() {
    return BlocBuilder<PrizeBloc, PrizeState>(
      builder: (context, state) {
        if (state is DiscoverPrizeFinished) {
          prizeProduct = state.prize;

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.productDetailsRoute,
                  arguments: ScreenArguments(
                      product: prizeProduct,
                      home: widget.home,
                      isFromPrize: true));
            },
            child: prizeProduct.images.isNotEmpty
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          child: Image.network(
                              prizeProduct.images[0].originalSource)),
                      state.duration != null && !state.duration.isNegative
                          ? Positioned(
                              top: 0,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: SlideCountdownSeparated(
                                    duration: state.duration,
                                  )))
                          : Container(),
                      state.lastWinner != null
                          ? Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Last winner: ${state.lastWinner}',
                                    style: TextStyle(
                                        backgroundColor: Colors.red,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  )
                : Container(),
          );
        }
        return Row(
          children: [],
        );
      },
    );
  }

  Widget _buildCardBottomNew(Product product) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.productDetailsRoute,
              arguments: ScreenArguments(product: product, home: widget.home));
        },
        child: Card(
          child: Container(
            width: width * 0.5,
            height: width * 0.4,
            child: Stack(
              children: [
                Align(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth * 0.15,
                        height: constraints.maxHeight * 0.5,
                        color: AppColors.indianRed,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              'Sale',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  alignment: Alignment.topLeft,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.00),
                            child: Image.network(
                              product.images[0].originalSource,
                              width: constraints.maxWidth * 0.7,
                              height: constraints.maxHeight * 0.6,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                product.title,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.compareAtPrice != null
                                        ? '${product.compareAtPrice} JD'
                                        : '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    ' ${product.price} JD',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildListProduct() {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        listProduct = [];

        if (state is DiscoverLoadFinished) {
          allProducts = state.products;
          listProduct = state.products != null
              ? state.products
                  .where((element) => element.tags
                      .contains(ProductType.values()[_currentIndexProductType]))
                  .toList()
              : [];
          if (listProduct.isNotEmpty) {
            listProduct.add(Product());
          }
          prizeProduct = state.prize;
          AppData.cartId ??= state.cartId;
        } else if (state is StartDiscoverLoad) {
          return Padding(
            padding: EdgeInsets.all(150),
            child: HeartbeatProgressIndicator(
              child: Icon(Icons.search),
            ),
          );
        }

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listProduct.length,
            controller: _controller,
            itemBuilder: (context, index) {
              var product = listProduct[index];
              if (index == listProduct.length - 1) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.productCategory,
                        arguments: {
                          "listProduct": allProducts,
                          "categoryName": categories[_currentIndexCategory],
                          "home": widget.home
                        });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      R.icon.more,
                      width: 100,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              } else {
                return CardProduct(
                  product: product,
                  onTapCard: () {
                    Navigator.pushNamed(
                        context, RouteConstant.productDetailsRoute,
                        arguments: ScreenArguments(
                            product: product, home: widget.home));
                  },
                );
              }
            });
      },
    );
  }

  Widget _buildListType() {
    return ListView.builder(
        itemCount: ProductType.values().length,
        itemBuilder: (context, index) {
          var type = ProductType.values()[index];
          _isSelectedProductType = _currentIndexProductType == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RotatedBox(
              quarterTurns: -1,
              child: FlatButton(
                  onPressed: () => _onClickFilterProductType(index, type),
                  child: Text(
                    type,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isSelectedProductType
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.grey),
                  )),
            ),
          );
        });
  }

  Widget _buildListCategory() {
    final controller = new ScrollController();
    return Scrollbar(
        isAlwaysShown: true,
        controller: controller,
        child: ListView.builder(
            shrinkWrap: true,
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              _isSelectedCategory = _currentIndexCategory == index;
              return FlatButton(
                  height: 1,
                  onPressed: () => _onClickFilterCategory(index, category),
                  child: Text(
                    category,
                    style: TextStyle(
                        height: 0.5,
                        fontWeight: FontWeight.bold,
                        color: _isSelectedCategory
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.grey),
                  ));
            }));
  }

  _onClickFilterProductType(int index, String type) {
    setState(() {
      _currentIndexProductType = index;
    });
    _currentProductType = type;

    BlocProvider.of<DiscoverBloc>(context).add(LoadingDiscoverEvent(
        category: _currentCategory, productType: _currentProductType));
  }

  _onClickFilterCategory(int index, String category) {
    setState(() {
      _currentIndexCategory = index;
    });

    _currentCategory = category;

    BlocProvider.of<DiscoverBloc>(context).add(LoadingDiscoverEvent(
        category: _currentCategory, productType: _currentProductType));
  }

  _launchURL(String url) async {
    await launch(url);
  }

  @override
  bool get wantKeepAlive => true;
}
