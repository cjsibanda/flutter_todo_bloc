import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo/todo_bloc.dart';
import 'bloc/todo/todo_event.dart';
import 'bloc/todo/todo_state.dart';
import 'models/todo.dart';
import 'package:uuid/uuid.dart';

//Entry Point
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do BLoC',
      home: BlocProvider(
        create: (_) => TodoBloc(),
        child: const TodoPage(),
      ),
    );
  }
}

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final uuid = Uuid();

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter task'),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final todo = Todo(id: uuid.v4(), task: value);
                  context.read<TodoBloc>().add(AddTodo(todo));
                  controller.clear();
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return ListTile(
                      title: Text(
                        todo.task,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) {
                          context.read<TodoBloc>().add(ToggleTodo(todo.id));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
