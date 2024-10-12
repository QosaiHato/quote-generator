import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoteapp/viewmodels/quote_view_model.dart';
import 'package:quoteapp/views/quote_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuoteViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quote Generator',
        theme: ThemeData(
            primaryColorDark: Colors.blue,
            indicatorColor: Colors.blue,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color.fromARGB(255, 49, 49, 49),
            appBarTheme: AppBarTheme(
              backgroundColor: Color.fromARGB(255, 49, 49, 49),
            )),
        home: QuoteScreen(),
      ),
    );
  }
}
