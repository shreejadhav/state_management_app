import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_app/provider/Item.dart';
import 'package:state_management_app/provider/MyCartModel.dart';

class ProviderScaffold extends StatefulWidget {
  ProviderScaffold({Key key}) : super(key: key);

  @override
  _ProviderScaffoldState createState() => _ProviderScaffoldState();
}

class _ProviderScaffoldState extends State<ProviderScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyCartModel(),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear),
                color: Colors.white,
                onPressed: () => Provider.of<MyCartModel>(
                        _scaffoldKey.currentContext,
                        listen: false)
                    .removeAll(),
              )
            ],
          ),
          body: Consumer<MyCartModel>(
            builder: (context, model, child) {
              return Column(
                children: <Widget>[
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total price: ${model.price}',
                        style: TextStyle(
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  child
                ],
              );
            },
            child: Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "Click on floating action button it will increase the price at to right"),
                    SizedBox(
                      height: 16,
                    ),
                    Builder(
                      builder: (_context) {
                        return FloatingActionButton(
                          onPressed: () {
                            Provider.of<MyCartModel>(_context, listen: false)
                                .addItem(Item());
                          },
                          child: Icon(Icons.add),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
