import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:reduxdemo/model/model.dart';
import 'package:reduxdemo/redux/actions.dart';

class CreateItemWidget extends StatefulWidget {
  final ViewModel viewModel;
  CreateItemWidget(this.viewModel);
  @override
  _CreateItemWidgetState createState() => _CreateItemWidgetState();
}

class _CreateItemWidgetState extends State<CreateItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ItemListWidget extends StatelessWidget {
  final ViewModel viewModel;
  ItemListWidget(this.viewModel);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: viewModel.items
          .map((Item item) => ListTile(
                title: Text(item.body),
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => viewModel.onDeleteItem(item),
                ),
              ))
          .toList(),
    );
  }
}

class ViewModel {
  final List<Item> items;
  final Function(String) onCreateItem;
  final Function(Item) onDeleteItem;

  ViewModel({
    this.items,
    this.onCreateItem,
    this.onDeleteItem,
  });

  factory ViewModel.create(store) {
    onCreateItem(String body) {
      store.dispatch(CreateItemAction(body: body));
    }

    onDeleteItem(Item item) {
      store.dispatch(DeleteItemAction(item: item));
    }

    return ViewModel(
      items: store.state.items,
      onCreateItem: onCreateItem,
      onDeleteItem: onDeleteItem,
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
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) => Column(
          children: [
            CreateItemWidget(viewModel),
            Expanded(
              child: ItemListWidget(viewModel),
            )
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) =>
            FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => viewModel.onCreateItem('Hello, World!'),
        ),
      ),
    );
  }
}
