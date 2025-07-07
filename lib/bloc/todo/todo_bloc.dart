import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../../models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState([])) {
    on<AddTodo>((event, emit) {
      final updated = List<Todo>.from(state.todos)..add(event.todo);
      emit(TodoState(updated));
    });

    on<ToggleTodo>((event, emit) {
      final updated = state.todos.map((todo) {
        return todo.id == event.id
            ? todo.copyWith(isCompleted: !todo.isCompleted)
            : todo;
      }).toList();
      emit(TodoState(updated));
    });
  }
}