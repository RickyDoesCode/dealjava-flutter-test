import 'package:dealjava/pages/basket.dart';
import 'package:dealjava/pages/home.dart';
import 'package:dealjava/pages/item_detail.dart';
import 'package:dealjava/pages/shop_detail.dart';
import 'package:dealjava/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Store>(
      create: (_) => Store(),
      child: AppWrapper(),
    );
  }
}

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store _store = Provider.of<Store>(context);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/basket': (BuildContext context) => BasketPage(),
        '/shop-detail': (BuildContext context) => ShopDetailPage(),
        '/item-detail': (BuildContext context) => ItemDetailPage(),
      },
      theme: _store.theme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
