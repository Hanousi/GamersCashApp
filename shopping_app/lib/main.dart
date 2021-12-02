import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/route/route_constants.dart';
import 'feature/helpers/shopify_config.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'bloc_observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}



void main() async {
  ShopifyConfig.setConfig(
    "fdfda880b301a54016ee2a5bc24af039",
    "gamers-store1.myshopify.com",
    "2021-10",
  );

  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if(Platform.isIOS) {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.requestPermission();
  }

  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    initialRoute: RouteConstant.homeRoute,
  ));
}
