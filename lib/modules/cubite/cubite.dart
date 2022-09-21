import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota/modules/cubite/states_cubite.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../components/archived.dart';
import '../../components/done.dart';
import '../../components/tasks.dart';

class Cubity extends Cubit<CubityState> {
  Cubity() : super(InitialState());

  static Cubity get(context) => BlocProvider.of(context);
  int navIndex = 1;
  List navList = const [NavArchived(), NavTasks(), NavDone()];
  void changNavIndex(value) {
    navIndex = value;
    emit(ChangeNavState());
  }

  IconData floatIcon = Icons.add;
  void floatIconAdd(IconData icona) {
    floatIcon = icona;
    emit(floatIconAddState());
  }

  void floatIconClosed(IconData icona) {
    floatIcon = icona;
    emit(floatIconClosedState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  var textController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  void createDatabase() async {
    var directory = await getDatabasesPath();
    var path = join(directory, 'notabase');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE noty (id INTEGER PRIMARY KEY, title TEXT, time TEXT , date TEXT ,status TEXT)');
    }, onOpen: (database) {
      getDatabase(database);
    });
    emit(createDatabaseState());
  }

  void insertDatabase(
    String title,
    String time,
    String date,
  ) {
    database.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO noty(title, time ,date ,status ) VALUES("$title", "$time" ,"$date","new")')
            .then((value) {
          emit(insertDatabaseState());
          getDatabase(database);
          navIndex = 1;
        }));
  }

  void getDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery!('SELECT * FROM noty').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(getDatabaseState());
    });
  }

  Future updateDatabase({required String status, required int id}) async {
    await database.rawUpdate(
        'UPDATE noty SET  status = ? WHERE id = ?', [status, id]).then((value) {
      getDatabase(database);
      emit(updateDatabaseState());
    });
  }

  void deleteDatabase(int id) {
    database.rawDelete('DELETE FROM noty WHERE id=?', [id]).then((value) {
      getDatabase(database);
      emit(DeleteDatabaseState());
    });
  }
}
