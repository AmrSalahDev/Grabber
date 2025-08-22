part of 'track_order_cubit.dart';

class TrackOrderState extends Equatable {
  final List<LatLng> routePoints;
  final LatLng driverLocation;
  final DeliveryStep deliveryStatus;
  final bool isMapReady;

  const TrackOrderState(
    this.routePoints,
    this.driverLocation,
    this.deliveryStatus,
    this.isMapReady,
  );

  TrackOrderState copyWith({
    List<LatLng>? routePoints,
    LatLng? driverLocation,
    DeliveryStep? deliveryStatus,
    bool? isMapReady,
  }) {
    return TrackOrderState(
      routePoints ?? this.routePoints,
      driverLocation ?? this.driverLocation,
      deliveryStatus ?? this.deliveryStatus,
      isMapReady ?? this.isMapReady,
    );
  }

  @override
  List<Object> get props => [
    routePoints,
    driverLocation,
    deliveryStatus,
    isMapReady,
  ];
}

final class TrackOrderInitial extends TrackOrderState {
  const TrackOrderInitial(
    super.routePoints,
    super.driverLocation,
    super.deliveryStatus,
    super.isMapReady,
  );
}
