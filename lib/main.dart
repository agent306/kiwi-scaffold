import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:kiwiscaffold/src/app.dart';
import 'package:kiwiscaffold/src/blocs/socket.bloc.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details, {bool forceReport = false}) {
  assert(details != null);
  assert(details.exception != null);
  // ---

  bool ifIsOverflowError = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError)
    ifIsOverflowError = !exception.diagnostics
        .any((e) => e.value.toString().startsWith("A RenderFlex overflowed by"));

  // Ignore if is overflow error.
  if (ifIsOverflowError)
    print('Overflow error.');

  // Throw others errors.
  else
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
};

  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock app in portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize Kiwi container as a singleton with 'scoped'
  Kiwi.Container container = Kiwi.Container.scoped();
  
  // Register the Bloc or any other singleton in order into the container
  SocketBloc _socketBloc = SocketBloc(container: container);
  container.registerInstance(_socketBloc);

  // Start flutter app
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(
      kiwi: container,
    ),
  ));
}