import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:quoteapp/viewmodels/quote_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteScreen extends StatefulWidget {
  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Lottie.asset(
          'assets/animation/appbar.json', width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          fit: BoxFit.fill,
        ),
        title: Text(
          'Random Quote',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Edu AU VIC WA NT Guides',
          ),
        ),
      ),
      body: Center(
        child: Consumer<QuoteViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Lottie.asset(
                'assets/animation/indicator.json', // Path to your Lottie file
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
                fit: BoxFit.fill,
              );
            } else if (viewModel.error.isNotEmpty) {
              return Text(viewModel.error);
            } else if (viewModel.quote != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  children: [
                    Text(
                      viewModel.quote!.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        // Use MediaQuery for responsiveness
                        fontFamily: 'Edu AU VIC WA NT Guides',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- ${viewModel.quote!.author}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Edu AU VIC WA NT Guides',
                      ),
                    ),
                    SizedBox(height: 50), // Adjusted height for better spacing
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center buttons
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            // Copy the quote to clipboard
                            Clipboard.setData(ClipboardData(
                                text:
                                    '${viewModel.quote!.text} \n -${viewModel.quote!.author}'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Quote copied to clipboard!'),
                              ),
                            );
                          },
                          child: Lottie.asset(
                            'assets/animation/copy.json', // Path to your Lottie file
                            width: 35, // Adjust width as needed
                            height: 35,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 20), // Space between buttons
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () => _launchTweet(
                              '"${viewModel.quote!.text}"\n-${viewModel.quote!.author}'),
                          child: Lottie.asset(
                            'assets/animation/share.json', // Path to your Lottie file
                            width: 35, // Adjust width as needed
                            height: 35,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 20), // Space between buttons
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () => viewModel.fetchQuote(),
                          child: Lottie.asset(
                            'assets/animation/indicator.json', // Path to your Lottie file
                            width: 35, // Adjust width as needed
                            height: 35, // Adjust height as needed
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Click on the button to get random quote',
                      style: TextStyle(
                        fontFamily: 'Edu AU VIC WA NT Guides',
                        color: Colors.white,
                        fontSize: 50,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50), // Adjusted height for better spacing
                    Row(
                      children: [
                        Image.asset(
                          'assets/left_finger.png',
                          width: 141,
                          height: 141,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () => viewModel.fetchQuote(),
                          child: Lottie.asset(
                            'assets/animation/indicator.json', // Path to your Lottie file
                            width: 35, // Adjust width as needed
                            height: 35, // Adjust height as needed
                            fit: BoxFit.fill,
                          ),
                        ),
                        Image.asset(
                          'assets/right_finger.png',
                          width: 143,
                          height: 143,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _launchTweet(String quote) async {
    final url = 'https://twitter.com/intent/tweet?text=$quote';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Twitter';
    }
  }
}
