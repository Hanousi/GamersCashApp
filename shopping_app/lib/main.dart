import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/route/route_constants.dart';
import 'feature/helpers/shopify_config.dart';

import 'app.dart';
import 'bloc_observer.dart';

void main() async {
  ShopifyConfig.setConfig(
    "fdfda880b301a54016ee2a5bc24af039",
    "gamers-store1.myshopify.com",
    "2021-10",
  );

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    initialRoute: RouteConstant.homeRoute,
  ));
}
