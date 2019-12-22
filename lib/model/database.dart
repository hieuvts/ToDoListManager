import 'package:moor_flutter/moor_flutter.dart';
import 'package:todolistapp/model/todo_model.dart';

part 'database.g.dart';

@UseMoor(
  tables: [Todo],
  queries: {
    '_getByType':'SELECT * FROM Todo WHERE todoType = ?',
    '_completeTask':'UPDATE Todo SET isFinished = true where ID = ?',
    '_deleteTask':'DELETE FROM Todo WHERE id =?'
  }
)
class Database{}
