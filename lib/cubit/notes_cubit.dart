import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_cubit/cubit/cubit_state.dart';
import 'package:notes_app_cubit/model/notes.dart';
import 'package:notes_app_cubit/repository/app_database.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesState(notes: null));
  List<Notes> arrNotes = [];
  var db = AppDatabase.db;

  Future<bool> addNotes(String title, String desc) async {
    bool? isCreated;
    try {
      isCreated = await db.addNotes(title: title, desc: desc);
      await fetchAllNotes();
    } catch (e) {
      print(e.toString());
    }
    return isCreated!;
  }

  Future<bool> deleteNote(int id) async {
    bool? isDelete;
    try {
      isDelete = await db.deleteNote(id);
      await fetchAllNotes();
    } catch (e) {
      print(e.toString());
    }
    return isDelete!;
  }

  Future<bool> updateNote(Notes note) async {
    bool? isUpdated;
    try {
      isUpdated = await db.updateNote(note);
      await fetchAllNotes();
    } catch (e) {
      print(e.toString());
    }
    return isUpdated!;
  }

  Future<void> fetchAllNotes() async {
    arrNotes = await db.fetchAllNotes();
    emit(NotesState(notes: arrNotes));
  }
}
