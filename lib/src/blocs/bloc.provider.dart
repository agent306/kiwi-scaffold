import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:kiwiscaffold/src/blocs/bloc.interface.dart';

class BlocProvider extends InheritedWidget {
  final Kiwi.Container kiwi;

  BlocProvider({
    Key key,
    Widget child,
    @required this.kiwi,
  }) : super(child: child, key: key);

  static T of<T extends BlocInterface>(BuildContext context) {
    BlocProvider provider =
        context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    T bloc = provider.kiwi.resolve<T>();
    return bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
