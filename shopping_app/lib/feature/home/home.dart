import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fsearch/fsearch.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shopping_app/feature/cart/ui/cart_screen.dart';
import 'package:shopping_app/feature/discover/ui/discover_screen.dart';
import 'package:shopping_app/feature/profile/profile_screen.dart';
import 'package:shopping_app/feature/wishlist/ui/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  DiscoverScreen _discoverScreen;
  CartScreen _cartScreen;
  Wishlist _wishlist;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _discoverScreen = DiscoverScreen(this);
    _cartScreen = CartScreen();
    _wishlist = Wishlist(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void routeTo(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
              if (index != 1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).unfocus();
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).requestFocus();
                });
              }
            },
            children: <Widget>[
              _discoverScreen,
              _wishlist,
              _cartScreen,
            ],
          ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 22.0, right: 22, bottom: 16.0, top: 8),
              child: GNav(
                gap: 8,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.pinkAccent,
                tabs: [
                  GButton(
                    icon: Ionicons.ios_home,
                    text: 'رئيسية',
                  ),
                  GButton(
                    icon: Ionicons.ios_search,
                    text: 'البحث',
                  ),
                  GButton(
                    icon: Ionicons.ios_cart,
                    text: 'السلة',
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() => _currentIndex = index);
                  _pageController.jumpToPage(index);
                  if (index != 1) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      FocusScope.of(context).unfocus();
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      FocusScope.of(context).requestFocus();
                    });
                  }
                },
              ),
            )));
  }
}
