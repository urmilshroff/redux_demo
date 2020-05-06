import 'package:reduxdemo/model/model.dart';
import 'package:reduxdemo/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(items: itemReducer(state.items, action));
}

List<Item> itemReducer(List<Item> state, dynamic action) {
  if (action is CreateItemAction) {
    return []
      ..addAll(state)
      ..add(Item(id: action.id, body: action.body));
  } else if (action is DeleteItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }
  return state;
}
