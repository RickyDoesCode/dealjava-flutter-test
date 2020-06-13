import 'package:barcode_scan/barcode_scan.dart';
import 'package:dealjava/utils/static/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Store with ChangeNotifier {
  // STATES
  final ThemeData _theme = ThemeData(
    appBarTheme: AppBarTheme(
      color: Color(0xFFF1523F),
    ),
  );
  final _restaurants = restaurantData;
  String _tableNumber = '';
  Map _restaurant = new Map();
  String _activeCategory = '';
  List<Map> _basket = new List();

  // GETTERS
  ThemeData theme() => _theme;
  List<Map> restaurants() => _restaurants;
  Map restaurant() => _restaurant;
  String tableNumber() => _tableNumber;
  String activeCategory() => _activeCategory;
  List basket() => _basket;
  List getCategories() {
    final List categories = [...this._restaurant['items'].keys];
    return categories;
  }
  List<Map> getItems() {
    return this._restaurant['items'][_activeCategory];
  }
  String formatPrice(int price) {
    var f = NumberFormat.currency(
      locale: 'id-ID',
      decimalDigits: 0,
      customPattern: '###,###,###,###,###',
    );
    return 'Rp ${f.format(price)}';
  }
  String getTotal() {
    int total = 0;
    for (int i = 0; i < _basket.length; i++) {
      final item = _basket[i];
      total += item['price'] * item['quantity'];  
    }
    return this.formatPrice(total);
  }
  String getBasketLength() {
    return _basket.length.toString();
  }
  
  // METHODS
  Future<Map> scan([Map restaurant]) async {
    if (restaurant != null) {
      this._restaurant = restaurant;
      if (this._tableNumber != '') {
        return this.checkValid();
      }
    }
    var result = await BarcodeScanner.scan();
    if (result.type == ResultType.Cancelled) {
      this.reset();
    } else {
      final String text = result.rawContent;
      final List<String> split = text.split('-');
      this._tableNumber = split.sublist(1).join("-");
    }
    notifyListeners();
    return this.checkValid();
  }
  Map checkValid() {
    if (this._restaurant.isEmpty) {
      return {
        'valid': false,
        'message': 'Please pick a restaurant!'
      };
    } else if (this._tableNumber == '') {
      return {
        'valid': false,
        'message': 'Please scan a barcode!'
      };
    } else {
      this.setDefaultCategory();
      return {
        'valid': true,
        'message': 'Clear to proceed!'
      };
    }
  }
  void reset() {
    this._restaurant = {};
    this._tableNumber = '';
    notifyListeners();
  }
  void setDefaultCategory() {
    final List categories = this.getCategories();
    this.setCategory(categories[0]);
  }
  void setCategory(String category) {
    this._activeCategory = category;
    notifyListeners();
  }
  void addToBasket(Map item) {
    bool exists = false;
    for (var i = 0; i < _basket.length; i++) {
      final Map basketItem = _basket[i];
      if (basketItem['name'] == item['name']) {
        _basket[i]['quantity'] += item['quantity'];
        _basket[i]['note'] = item['note'];
        exists = true;
      }
    }
    if (exists == false) {
      _basket.add(item);  
    }
    notifyListeners();
  }
  void removeFromBasket(int index) {
    _basket.removeAt(index);
    notifyListeners();
  }
  void checkout() {
    _basket = new List();
    notifyListeners();
  }
}
