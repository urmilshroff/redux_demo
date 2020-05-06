import 'package:flutter/material.dart';
import 'package:reduxdemo/model/model.dart';

class CreateItemAction {
  int _id = 0;
  final String body;
  CreateItemAction({@required this.body}) {
    _id++;
  }
  int get id => _id;
}

class DeleteItemAction {
  final Item item;
  DeleteItemAction({@required this.item});
}
