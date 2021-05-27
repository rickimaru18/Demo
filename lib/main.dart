import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/env.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/repository.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/non_ui/utils/logger.dart';
import 'package:morphosis_flutter_demo/routes.dart';
import 'package:morphosis_flutter_demo/ui/screens/index.dart';
import 'package:morphosis_flutter_demo/ui/widgets/error_widget.dart';
import 'package:provider/provider.dart';

const title = 'Morphosis Demo';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();
  runZonedGuarded(() {
    runApp(FirebaseApp());
  }, (error, stackTrace) {
    logger('Main', 'runZonedGuarded: Caught error in my root zone.');
  });
}

class FirebaseApp extends StatefulWidget {
  @override
  _FirebaseAppState createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await FirebaseManager().initialise();

    debugPrint("firebase initialized");

    // Pass all uncaught errors to Crashlytics.
    final FlutterExceptionHandler? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      // Forward to original handler.
      originalOnError?.call(errorDetails);
    };
  }

  // Define an async function to initialize FlutterFire
  Future<void> initialize() async {
    if (_error) {
      setState(() {
        _error = false;
      });
    }

    try {
      await _initializeFlutterFire();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      logger('FirebaseApp', 'Exception: $e');
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error || !_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: Scaffold(
          body: _error
              ? ErrorMessage(
                  message: "Problem initialising the app",
                  buttonTitle: "RETRY",
                  onTap: initialize,
                )
              : Container(),
        ),
      );
    }
    return App();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Repository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: routes,
        initialRoute: IndexPage.route,
      ),
    );
  }
}
