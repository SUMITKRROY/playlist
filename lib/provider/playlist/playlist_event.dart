part of 'playlist_bloc.dart';

@immutable
abstract class PlayListEvent {}
class PlayListsuccessEvent extends PlayListEvent {
  String id;
  String title;
  String content;
  String imagePath;
  String date;
  String startTime;
  String endTime;

  PlayListsuccessEvent(
      {required this.id,
      required this.title,
      required this.content,
      required this.imagePath,
      required this.date,
      required this.startTime,
      required this.endTime});


}
class NoteDeleteEvent extends PlayListEvent{
  int id;

  NoteDeleteEvent({required this.id});
}
class NotegetEvent extends PlayListEvent{
}
