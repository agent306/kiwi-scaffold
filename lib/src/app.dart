import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:kiwiscaffold/src/theme.dart';
import 'package:kiwiscaffold/src/blocs/socket.bloc.dart';
import 'package:kiwiscaffold/src/blocs/bloc.provider.dart';
import 'package:kiwiscaffold/src/ui/home.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  final Kiwi.Container kiwi;
  App({Key key, this.kiwi}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SocketBloc _socketBloc;

  @override
  void initState() {
    super.initState();
  }

  isCurrentRoute(String newRouteName) {
    bool isNewRouteSameAsCurrent = false;

    navKey.currentState.popUntil((route) {
      if (route.settings.name == newRouteName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    return isNewRouteSameAsCurrent;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_socketBloc == null) {
      _socketBloc = widget.kiwi.resolve<SocketBloc>();
    }
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      kiwi: widget.kiwi,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WillPopScope(
          onWillPop: () async {
            return !await navKey.currentState.maybePop();
          },
          child: Navigator(
            key: navKey,
            initialRoute: 'app',
            onGenerateRoute: (RouteSettings settings) {
              // final Map<String, dynamic> arguments = settings.arguments;

              switch (settings.name) {
                case 'app':
                  return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => Home(),
                  );
                  break;
                default:
                  return null;
                  break;
              }
            },
          ),
        ),
        theme: AppTheme.buildThemeData(
          context,
          brightness: Brightness.light,
          accentColor: Color(0xFFC58917),
          accentColorLight: Color(0xFFC58917),
          primaryColor: Color(0xFF02a859),
          primaryColorLight: Color(0xFF02a859),
          backgroundColor: Color(0xFF363636),
          backgroundColorLight: Color(0xFFDBD9D9),
        ),
      ),
    );
  }
}