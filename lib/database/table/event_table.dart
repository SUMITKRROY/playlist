import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../database_helper.dart';

class PlayListTable {
  static const String PLAYLIST_TABLE = "notes";
  static const String id = "Id";
  static const String title = "Title";
  static const String content = "Content";
  static const String imagePath = "ImagePath";
  static const String date = "Date";
  static const String startTime = "StartTime";
  static const String endTime = "EndTime";

  static const String CREATE = '''
    CREATE TABLE IF NOT EXISTS $PLAYLIST_TABLE (
    $id INTEGER PRIMARY KEY,
    $title TEXT DEFAULT '',
    $content TEXT DEFAULT '',
    $imagePath TEXT DEFAULT '',    
    $date TEXT DEFAULT '',       
    $startTime TEXT DEFAULT '',
    $endTime TEXT DEFAULT ''
    )
  ''';


  // Define a function that inserts notes into the database
  Future<void> insert(Map<String, dynamic> map) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    // Get a reference to the database.
    final db = await databaseHelper.database;
    // In this case, replace any previous data.
    await db.insert(
      PLAYLIST_TABLE,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to retrieve all notes from the database
  Future<List<Map<String, dynamic>>> getPlayList() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.query(PLAYLIST_TABLE);
  }

  // Method to delete a note from the database
  Future<int> deleteNote(int noteId) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.delete(
      PLAYLIST_TABLE,
      where: '$id = ?',
      whereArgs: [noteId],
    );
  }

  // Method to update a note in the database
  Future<int> updateNote(Map<String, dynamic> updatedNote) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;

    int id = updatedNote['Id'];
    String updatedTitle = updatedNote['Title'];
    String updatedContent = updatedNote['Content'];

    return await db.update(
      PLAYLIST_TABLE,
      {
        title: updatedTitle,
        content: updatedContent,
      },
      where: 'Id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to get note details by ID
  Future<Map<String, dynamic>> getNoteById(int noteId) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;

    List<Map<String, dynamic>> result = await db.query(
      PLAYLIST_TABLE,
      where: '$id = ?',
      whereArgs: [noteId],
    );

    // If the query returns a result, return the first (and only) row
    if (result.isNotEmpty) {
      return result.first;
    } else {
      // If no result is found, return an empty map or handle it as needed
      return {};
    }
  }
}
