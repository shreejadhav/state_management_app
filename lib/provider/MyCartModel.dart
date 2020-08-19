import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'Item.dart';

class MyCartModel extends ChangeNotifier{
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items=> UnmodifiableListView(_items);

  int get price => _items.length*47;

  void addItem(Item item){
    _items.add(item);
    print('item added $price');
    notifyListeners();
  }

  void removeAll(){
    _items.clear();
    notifyListeners();
  }
}