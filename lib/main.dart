import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/view/home_screen.dart';
import 'package:task_1/view_models/bloc_books/books_bloc.dart';
import 'package:task_1/view_models/cubit/calender_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalenderCubit()),
        BlocProvider(create: (context) => BooksBloc()),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}
