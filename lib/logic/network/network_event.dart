import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NetworkEvent {
  const NetworkEvent();
}

class NetworkConnectedEvent extends NetworkEvent {
  const NetworkConnectedEvent();
}

class NetworkDisconnectedEvent extends NetworkEvent {
  const NetworkDisconnectedEvent();
}
