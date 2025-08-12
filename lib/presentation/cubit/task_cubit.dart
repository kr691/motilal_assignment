import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;
  TaskCubit(this.repository) : super(TaskInitial());

  void loadTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await repository.fetchTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void addTask(TaskModel newTask) async {
    if (state is TaskLoaded) {
      final currentTasks = List<TaskModel>.from((state as TaskLoaded).tasks);
      emit(TaskLoading()); // show loader
      try {
        await repository.addTask(newTask);
        currentTasks.add(newTask);
        emit(TaskLoaded(currentTasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    }
  }

  void updateTask(TaskModel updatedTask) async {
    if (state is TaskLoaded) {
      final currentTasks = List<TaskModel>.from((state as TaskLoaded).tasks);
      emit(TaskLoading()); // show loader
      try {
        await repository.updateTask(updatedTask);
        final index = currentTasks.indexWhere((t) => t.id == updatedTask.id);
        if (index != -1) {
          currentTasks[index] = updatedTask;
        }
        emit(TaskLoaded(currentTasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    }
  }

  void deleteTask(int id) async {
    if (state is TaskLoaded) {
      final currentTasks = List<TaskModel>.from((state as TaskLoaded).tasks);
      emit(TaskLoading()); // show loader
      try {
        await repository.deleteTask(id);
        currentTasks.removeWhere((t) => t.id == id);
        emit(TaskLoaded(currentTasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    }
  }
}
