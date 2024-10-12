import 'package:flutter/material.dart';
import 'package:quoteapp/models/quote_model.dart';
import 'package:quoteapp/services/quote_service.dart';

class QuoteViewModel extends ChangeNotifier {
  Quote? _quote;
  bool _isLoading = false;
  String _error = '';

  final QuoteService _quoteService = QuoteService();

  Quote? get quote => _quote;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchQuote() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _quote = await _quoteService.fetchRandomQuote();
    } catch (e) {
      _error = 'Failed to fetch quote';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchQuoteByKeyword(String keyword) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    final result = await _quoteService.fetchQuoteByKeyword(keyword);
    if (result != null) {
      _quote = result;
    } else {
      _error = 'Failed to fetch quote';
    }

    _isLoading = false;
    notifyListeners();
  }
}
