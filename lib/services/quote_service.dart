import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quoteapp/models/quote_model.dart';

class QuoteService {
  final String _baseUrl = 'https://zenquotes.io/api/random';
  Future<Quote?> fetchQuoteByKeyword(String keyword) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?keyword=$keyword'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Quote.fromJson(data);
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Quote> fetchRandomQuote() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return Quote(
        text: data[0]['q'], // The quote text
        author: data[0]['a'], // The author of the quote
      );
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
