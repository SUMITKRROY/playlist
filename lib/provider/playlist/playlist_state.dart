part of 'playlist_bloc.dart';

@immutable
abstract class PlayListState {}

class PlayListInitial extends PlayListState {}
class PlayListLoading extends PlayListState {}
class PlayListSuccess extends PlayListState {
  List<Map<String, dynamic>> PlayList = [];

  PlayListSuccess(this.PlayList);
}