import 'dart:async';

import 'package:state_management_app/provider/Item.dart';

class ItemsStream {

  Stream<Item>  get itemsStream => Stream.periodic(Duration(seconds: 1),(sec){
    return Item()..value=sec.toString();
  });

  void dispose(){
  }
}