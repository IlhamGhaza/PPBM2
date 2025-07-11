import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../core/variables.dart';
import '../model/book_response_model.dart';

class BookRemoteDatasource {
  // Get all books
  Future<List<BookResponseModel>> getBooks() async {
    try {
      final response = await http.get(
        Uri.parse(Variables.baseUrl),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => BookResponseModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }

  // Get book by id
  Future<BookResponseModel> getBookById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/$id'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return BookResponseModel.fromMap(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Book not found');
      } else {
        throw Exception('Failed to load book: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch book: $e');
    }
  }

  // Create a new book
  Future<BookResponseModel> createBook(BookResponseModel book) async {
    try {
      final response = await http.post(
        Uri.parse(Variables.baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
        },
        body: jsonEncode(book.toMap()),
      );

      if (response.statusCode == 201) {
        return BookResponseModel.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to create book: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create book: $e');
    }
  }

  // Update an existing book
  Future<BookResponseModel> updateBook(BookResponseModel book) async {
    try {
      final response = await http.patch(
        Uri.parse('${Variables.baseUrl}/${book.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
        },
        body: jsonEncode(book.toMap()),
      );

      if (response.statusCode == 200) {
        return BookResponseModel.fromMap(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Book not found');
      } else {
        throw Exception('Failed to update book: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }

  // Delete a book
  Future<void> deleteBook(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Variables.baseUrl}/$id'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else if (response.statusCode == 404) {
        throw Exception('Book not found');
      } else {
        throw Exception('Failed to delete book: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete book: $e');
    }
  }

  // Search for books
  Future<List<BookResponseModel>> searchBook(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/search?q=$query'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => BookResponseModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to search books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search books: $e');
    }
  }
}
