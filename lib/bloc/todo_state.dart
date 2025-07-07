import 'package:equatable/equatable.dart';
import '../../models/todo.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState(this.todos);

  @override
  List<Object?> get props => [todos];
}