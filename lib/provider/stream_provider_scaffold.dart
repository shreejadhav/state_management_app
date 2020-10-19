import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_app/provider/Item.dart';
import 'package:state_management_app/provider/ItemsStream.dart';

class StreamProviderScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider.value(
      value: ItemsStream().itemsStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stream provider example"),
        ),
        body: Center(
          child: Consumer<Item>(builder: (_context,item,widget){
            return Text('Stream providers ${item.toString()}');
          },),
        ),
        floatingActionButton: Builder(
          builder:(_context)=> FloatingActionButton(
            onPressed: () {
              var streamProvider=Provider.of<Item>(_context) as StreamProvider;
            },
            child: Icon(Icons.play_arrow),
          ),
        ),
      ),
    );
  }
}
