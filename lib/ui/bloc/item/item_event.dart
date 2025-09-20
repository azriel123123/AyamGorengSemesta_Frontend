part of 'item_bloc.dart';

@immutable
sealed class ItemEvent {}

/// Ambil semua item
class ItemFetched extends ItemEvent {}

/// Filter item berdasarkan subcategoryId
class ItemSubCategoryFetched extends ItemEvent {
  final int? subcategoryId;
  ItemSubCategoryFetched({this.subcategoryId});
}
