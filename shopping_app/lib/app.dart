import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_app/feature/auth/login/bloc/login_bloc.dart';
import 'package:shopping_app/feature/discover/bloc/prize_bloc.dart';
import 'package:shopping_app/feature/product_category/bloc/collection_bloc.dart';
import 'package:shopping_app/feature/wishlist/bloc/wishlist_bloc.dart';
import 'package:shopping_app/localization/app_localization.dart';
import 'package:shopping_app/resources/app_theme.dart';
import 'package:shopping_app/route/router.dart';

import 'feature/cart/bloc/cart_bloc.dart';
import 'feature/discover/bloc/discover_bloc.dart';
import 'feature/home/home.dart';
import 'feature/product_details/bloc/product_details_bloc.dart';
import 'feature/profile/bloc/profile_bloc.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({Key key, this.initialRoute}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  final discoverBloc = DiscoverBloc();
  final collectionBloc = CollectionBloc();
  final cartBloc = CartBloc();
  final productDetailsBloc = ProductDetailsBloc();
  final profileBloc = ProfileBloc();
  final loginBloc = LoginBloc();
  final prizeBloc = PrizeBloc();
  final wishlistBloc = WishlistBloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  ThemeData _themeData = buildLightTheme();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return discoverBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return collectionBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return prizeBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return wishlistBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return cartBloc..add(CartLoadingEvent());
            },
          ),
          BlocProvider(
            create: (context) {
              return profileBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return productDetailsBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              return loginBloc;
            },
          ),
        ],
        child: MaterialApp(
            initialRoute: widget.initialRoute,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.generateRoute,
            locale: Locale('en', ''),
            supportedLocales: [
              const Locale('en', ''), // English
              const Locale('vi', ''), // Vietnamese
            ],
            localizationsDelegates: [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: _themeData,
            home: HomeScreen()));
  }

  void changeTheme(ThemeData themeData) {
    setState(() {
      _themeData = themeData;
    });
  }

  @override
  void dispose() {
    discoverBloc.close();
    collectionBloc.close();
    cartBloc.close();
    productDetailsBloc.close();
    profileBloc.close();
    loginBloc.close();
    prizeBloc.close();
    super.dispose();
  }
}
