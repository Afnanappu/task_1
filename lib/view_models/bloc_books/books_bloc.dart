import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/models/book_model.dart';
import 'package:task_1/services/book_service.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final _service = BookService();
  BooksBloc() : super(BooksInitial()) {
    on<SearchBooksEvent>((event, emit) async {
      emit(BooksLoading());
      try {
        final books = await _service.searchBooks(query: event.query);

        emit(BooksLoaded(bookModel: books));
      } catch (e) {
        emit(BooksError(error: e.toString()));
      }
    });
  }
}
