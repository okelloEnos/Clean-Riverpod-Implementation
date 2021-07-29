import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
const uuid = Uuid();

/// A read-only description of a todo-item
class Todo{
  final String id;
  final String description;
  final bool completed;

  Todo({required this.id, required this.description, this.completed = false});

  @override
  String toString() {
    // TODO: implement toString
    return 'Todo(id: $id, description: $description, completed: $completed)';
  }

}

/// An object that controls a list of [Todo].
class TodoList extends StateNotifier<List<Todo>>{
  TodoList([List<Todo> ? initialTodos]) : super(initialTodos ?? []);

  void add(String description){
    state = [...state, Todo(id: uuid.v4(), description: description)];
  }

  void toggle(String id){
    state = [
      for(final todo in state)
        if(todo.id == id)
          Todo(
          id: todo.id,
          completed: !todo.completed,
    description: todo.description
          )
        else
          todo

    ];
  }

  void edit({required String id, required String description}){
    state = [
      for(final todo in state)
        if(todo.id == id)
          Todo(id: todo.id, description: description, completed: todo.completed)
      else
        todo
    ];
  }

  void remove(Todo target){
    state = state.where((todo) => todo.id != target.id).toList();
  }
}