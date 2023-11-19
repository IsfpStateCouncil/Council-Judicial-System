import 'package:council_of_state/page/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../functions/AfterBuild.dart';
import '../functions/AwesomeConnection.dart';
import '../providerclasses.dart/providerlanguage.dart';

class ConnectionError extends StatelessWidget {
  ConnectionError({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      createAwesome(context, languageProvider);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 162, 46), //<-- SEE HERE
        centerTitle: true,
        title: Text(languageProvider.getCurrentData("EgyptianStateCouncil")),
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
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
            Center(
              child: Text(
                languageProvider.getCurrentData("requireNetWorkMes"),
                textAlign: TextAlign.center,
                //_boxLogin.get("errorMessage"),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                continueConnection(context, languageProvider);
              },
              icon: Icon(Icons.refresh),
              iconSize: 100,
              focusColor: Colors.blueAccent,
              highlightColor: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
