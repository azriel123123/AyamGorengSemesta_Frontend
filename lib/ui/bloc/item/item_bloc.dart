import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_system/data/datasource/item_remote_datasource.dart';

import '../../../../data/model/response/item_response_model.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRemoteDatasource itemRemoteDatasource;
  List<Item> items = [];

  ItemBloc(this.itemRemoteDatasource) : super(ItemInitial()) {
    /// Ambil semua item
    on<ItemFetched>((event, emit) async {
      print('[ItemBloc] Fetching items...');
      emit(ItemLoading());
      final response = await itemRemoteDatasource.getItems();
      response.fold(
            (l) {
          print('[ItemBloc] Failed: $l');
          emit(ItemFailure(message: l));
        },
            (r) {
          items = r.item;
          print('[ItemBloc] Success: ${r.item.length} items');
          emit(ItemSuccess(r.item));
        },
      );
    });

    /// Filter berdasarkan subcategoryId
    on<ItemSubCategoryFetched>((event, emit) async {
      emit(ItemLoading());
      final response = await itemRemoteDatasource.getItems();

      final filteredItems = event.subcategoryId == null
          ? items
          : items
          .where((item) => item.subcategoryId == event.subcategoryId)
          .toList();

      response.fold(
            (l) => emit(ItemFailure(message: l)),
            (r) {
          emit(ItemSuccess(filteredItems));
        },
      );
    });
  }
}
