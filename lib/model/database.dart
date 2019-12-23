import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart';


class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime()();
  TextColumn get task => text()();
  TextColumn get description => text()();
  BoolColumn get isFinish => boolean()();
  IntColumn get todoType => integer()();
}
enum TodoType { TYPE_TASK, TYPE_EVENT }

@UseMoor(tables: [
  Todo
], queries: {
  '_getByType':
      'SELECT * FROM todo WHERE todo_type = ? order by is_finish',
  '_completeTask': 'UPDATE todo SET is_finish = 1 WHERE id = ?',
  '_deleteTask': 'DELETE FROM todo WHERE id = ?'
})


class Database extends _$Database with ChangeNotifier{
  // we tell the database where to store the data with this constructor
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'todos_file.sqlite', logStatements: true));
  @override
  int get schemaVersion => 1;
  Stream<List<TodoData>> getTodoByType(int type) => watchGetByType(type);

  Future insertTodoEntries(TodoData entry) {
    return transaction((tx) async {
      await tx.into(todo).insert(entry);
    });
  }

  Future completeTodoEntries(int id) {
    return transaction((tx) async {
      await _completeTask(id, operateOn: tx);
    });
  }

  Future deleteTodoEntries(int id) {
    return transaction((tx) async {
      await _deleteTask(id, operateOn: tx);
    });
  }
}