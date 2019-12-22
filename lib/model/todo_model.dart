
import 'package:moor_flutter/moor_flutter.dart';

class Todo extends Table{
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime()();
  TextColumn get taskName => text()();
  TextColumn get taskDescription => text()();
  BoolColumn get isFinished => boolean()();
  IntColumn get todoType => integer()();//Task or Event
}
enum TodoType { TYPE_TASK, TYPE_EVENT}