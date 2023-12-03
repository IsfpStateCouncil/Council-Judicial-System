import 'package:council_of_state/data/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerclasses.dart/providerlanguage.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StaticData.appBarColor, //<-- SEE HERE
        title: Text(
          languageProvider.getCurrentData('EgyptianStateCouncil'),
          style: TextStyle(
              fontFamily: StaticData.fontFamily,
              fontSize: 20,
              color: StaticData.backgroundColors
              // Add other text styles as needed
              ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: StaticData.backgroundColors),
              ),
            ),
          )
        ],
      ),
      /* backgroundColor: Theme.of(context).colorScheme.primary,*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 100),
            Text(
              languageProvider.getCurrentData('errorinusernameorpassword'),
              //_boxLogin.get("errorMessage"),
              style: TextStyle(
                  fontFamily: StaticData.fontFamily,
                  fontSize: 20,
                  color: StaticData.font
                  // Add other text styles as needed
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
