import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { increment, decrement }

int countReducer(int state, dynamic action) {
  if (action == Actions.increment)
    return state + 1;
  else if (action == Actions.decrement)
    return state - 1;
  else
    return state;
}

void main() {
  final store = Store<int>(countReducer, initialState: 0);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        title: 'Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux Demo'),
      ),
      body: Center(
        child: StoreConnector<int, String>(
          // why int and String?
          converter: (store) => store.state.toString(), // what
          builder: (context, count) {
            return Text(
              count,
              style: TextStyle(fontSize: 64.0),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(Actions.increment);
            },
            builder: (context, callback) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: callback,
              );
            },
          ),
          StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(Actions.decrement);
            },
            builder: (context, callback) {
              return FloatingActionButton(
                child: Icon(Icons.remove),
                onPressed: callback,
              );
            },
          ),
        ],
      ),
    );
  }
}
