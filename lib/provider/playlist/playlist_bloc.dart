import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../database/table/event_table.dart';



part 'playlist_event.dart';
part 'playlist_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  PlayListBloc() : super(PlayListInitial()) {
    on<PlayListsuccessEvent>((event, emit) {
      emit(PlayListLoading());
      try{
        Map<String, dynamic> data = {
          'id': event.id,
          'title': event.title,
          'content': event.content,
          'imagePath': event.imagePath,
          'date': event.date,
          'startTime': event.startTime,
          'endTime': event.endTime,
        };
        // Call insert function to insert data into the table
        PlayListTable().insert(data);
        print("data ${data}");
        emit(PlayListInitial());
      }catch(e){
        print(e);
      }

    });
    on<NotegetEvent>((event, emit) async {
      emit(PlayListLoading());
      try {
        List<Map<String, dynamic>> loadedPlayList = await PlayListTable().getPlayList();
        emit(PlayListSuccess(loadedPlayList));
      }catch(e){
        print(e);
      }

    });
    on<NoteDeleteEvent>((event, emit) async {
      emit(PlayListLoading());
      try {
        await PlayListTable().deleteNote(event.id);

      } catch (e) {
        print("Error deleting note: $e");
      }

    });

  }
}
