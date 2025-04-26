part of 'books_bloc.dart';

@immutable
sealed class BooksEvent {}

class SearchBooksEvent extends BooksEvent {
  final String query;
  SearchBooksEvent({required this.query});
}
