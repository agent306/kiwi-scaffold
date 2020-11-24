import 'dart:async';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:kiwiscaffold/src/blocs/bloc.interface.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketBloc implements BlocInterface {
  IO.Socket socket;

  BehaviorSubject<bool> socketStatus = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<dynamic> socketEvents = BehaviorSubject<dynamic>.seeded(null);

  SocketBloc({Kiwi.Container container}) {
    this._initialize();
  }

  _initialize() async {
    this.socket = IO.io('http://localhost:9999');

    socket.on('connect', (_) {
      socketStatus.add(true);
      print('Socket connected!');
    });
    
    socket.on('event', (data) {
      socketEvents.add(data);
    });

    socket.on('disconnect', (_) {
      socketStatus.add(false);
    });

    // any custom emit events here
    // socket.on('some-other-channel-perhaps', (_) => print(_));

    print("Socket connection initialized");
  }

  sendToServer(String channel, dynamic data) async {
    if (this.socket != null && this.socket.connected) {
      socket.emit(channel, data);
      print("Message send to $channel");
    } else {
      print("Socket isn't initialized yet");
    }
  }

  @override
  Future<void> dispose() async {
    await socketStatus.drain();
    await socketStatus.close();

    await socketEvents.drain();
    await socketEvents.close();

    this.socket.disconnect();
  }
}
