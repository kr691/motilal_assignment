import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/task_repository.dart';
import 'presentation/cubit/task_cubit.dart';
import 'presentation/screens/task_list_screen.dart';

void main() {
  final repository = TaskRepository();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => TaskCubit(repository)..loadTasks(),
        child: const TaskListScreen(),
      ),
    ),
  );
}
