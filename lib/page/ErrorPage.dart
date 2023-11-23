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
        backgroundColor: Color.fromARGB(255, 240, 162, 46), //<-- SEE HERE

        title: Text(languageProvider.getCurrentData('EgyptianStateCouncil')),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
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
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
