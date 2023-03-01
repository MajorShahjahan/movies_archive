import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'network_event.dart';
import 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription? networkSubscription;

  NetworkBloc() : super(const NetworkInitialState()) {
    networkSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(const NetworkConnectedEvent());
      } else {
        add(const NetworkDisconnectedEvent());
      }
    });

    on<NetworkConnectedEvent>(
        (event, emit) => emit(const NetworkConnectedState()));
    on<NetworkDisconnectedEvent>(
        (event, emit) => emit(const NetworkDisconnectedState()));
  }

  @override
  Future<void> close() {
    networkSubscription?.cancel();
    return super.close();
  }
}
