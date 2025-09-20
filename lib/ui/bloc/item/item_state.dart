part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemSuccess extends ItemState {
  final List<Item> items;
  ItemSuccess(this.items);
}

class ItemFailure extends ItemState {
  final String message;
  ItemFailure({required this.message});
}
