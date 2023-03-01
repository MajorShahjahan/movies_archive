import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NetworkState {
  const NetworkState();
}

class NetworkInitialState extends NetworkState {
  const NetworkInitialState();
}

class NetworkConnectedState extends NetworkState {
  const NetworkConnectedState();
}

class NetworkDisconnectedState extends NetworkState {
  const NetworkDisconnectedState();
}
