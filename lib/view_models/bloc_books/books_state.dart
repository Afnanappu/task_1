part of 'books_bloc.dart';

@immutable
sealed class BooksState {}

final class BooksInitial extends BooksState {}

final class BooksLoading extends BooksState {}

final class BooksLoaded extends BooksState {
  final BookModel bookModel;

  BooksLoaded({required this.bookModel});
}

final class BooksError extends BooksState {
  final String error;

  BooksError({required this.error});
}
