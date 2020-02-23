import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'router/application.dart';
import 'router/routes.dart';
import 'loading.dart';
import 'provider/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: '课程预约app',
        theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Application.router.generator,
        home: Loading(),
      ),
    );
  }
}