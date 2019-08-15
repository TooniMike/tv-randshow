import 'package:flutter/material.dart';

import 'package:tv_randshow/config/flavor_config.dart';
import 'package:tv_randshow/config/secure_keys.dart';
import 'package:tv_randshow/generated/i18n.dart';

void main() {
  FlavorConfig(
      /// Populate a string [apiKey] in [secure_keys.dart], or put below your personal API Key from TMDB
      flavor: Flavor.PROD,
      values: FlavorValues(baseUrl: 'api.themoviedb.org', apiKey: apiKey));

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [I18n.delegate],
      supportedLocales: I18n.delegate.supportedLocales,
      localeResolutionCallback: I18n.delegate.resolution(fallback: Locale('en', 'US')),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).name_app),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
