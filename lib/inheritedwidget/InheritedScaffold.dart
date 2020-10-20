import 'package:flutter/material.dart';
import 'package:state_management_app/inheritedwidget/ModelBinding.dart';
import 'package:state_management_app/inheritedwidget/MyModel.dart';

class InheritedScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelBinding<MyModel>(
      initialModel: MyModel(value: 0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inherited widget'),
        ),
        body: ChildWidget(),
        floatingActionButton: Builder(
          builder: (_context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              var oldModel = ModelBinding.of<MyModel>(_context);
              ModelBinding.update<MyModel>(
                  _context, MyModel(value: oldModel.value + 1));
            },
          ),
        ),
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final int count;

  MyInheritedWidget({this.count = 0, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return count != (oldWidget as MyInheritedWidget).count;
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = ModelBinding.of<MyModel>(context);
    return Center(
      child: Text('This is the center${model.value}'),
    );
  }
}
