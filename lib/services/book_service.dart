import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task_1/models/book_model.dart';

class BookService {
  Future<BookModel> searchBooks({required String query}) async {
    try {
      final url = Uri.parse('https://gutendex.com/books/?search=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return BookModel.fromJson(json);
      }

      throw Exception('Failed to load books');
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
