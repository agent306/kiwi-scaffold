import 'package:flutter/material.dart';
import 'package:kiwiscaffold/src/blocs/bloc.provider.dart';
import 'package:kiwiscaffold/src/blocs/socket.bloc.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SocketBloc _socketBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (this._socketBloc == null) {
      _socketBloc = BlocProvider.of<SocketBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<bool>(
          stream: _socketBloc.socketStatus,
          builder: (context, statusSnapshot) {
            String title = "Socket Status: ";
            if (statusSnapshot.hasData && statusSnapshot.data != null) {
              if (statusSnapshot.data) {
                title += "Connected";
              } else {
                title += "Disconnected";
              }
            }

            return Text(title);
          }
        ),
      ),
      body: Center(
        child: Container(
           child: Text("Welcome Home"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(label: Text("Send test data to Socket server"), onPressed: () {
        this._socketBloc.sendToServer("test-channel", "You are awesome");
      },),
    );
  }
}