// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// 🌎 Project imports:
import 'package:grabber/features/order_track/domain/usecases/fetch_route_usecase.dart';
import 'package:grabber/features/order_track/enum/delivery_step.dart';

part 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  final FetchRouteUseCase fetchRouteUseCase;
  TrackOrderCubit(this.fetchRouteUseCase)
    : super(TrackOrderInitial([], LatLng(0, 0), DeliveryStep.confirmed, false));

  Timer? simulationTimer;
  List<LatLng> routePoints = [];
  int currentRouteIndex = 0;

  static const LatLng storeLocation = LatLng(30.0444, 31.2357);
  static const LatLng deliveryLocation = LatLng(30.0544, 31.2257);
  LatLng driverLocation = TrackOrderCubit.storeLocation;

  Future<void> fetchRoute() async {
    if (isClosed) return;
    try {
      routePoints = await fetchRouteUseCase(storeLocation, deliveryLocation);
      driverLocation = routePoints.first;
      currentRouteIndex = 0;

      emit(
        TrackOrderState(
          routePoints,
          driverLocation,
          DeliveryStep.confirmed,
          false,
        ),
      );
    } catch (e) {
      //emit(TrackOrderError(e.toString()));
    }
  }

  void startDriverSimulation({
    required MapController mapController,
    required bool isMapReady,
  }) {
    if (isClosed) return;
    simulationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (routePoints.isEmpty) return;

      if (currentRouteIndex < routePoints.length - 1) {
        currentRouteIndex++;
        driverLocation = routePoints[currentRouteIndex];

        final deliveryStep = getDeliveryStep(
          currentRouteIndex,
          routePoints.length,
        );

        if (deliveryStep == DeliveryStep.packing) {
          mapController.move(storeLocation, mapController.camera.zoom);
        }

        if (state.deliveryStatus == DeliveryStep.packing) {
          Future.delayed(const Duration(seconds: 5), () {
            emit(
              state.copyWith(
                deliveryStatus: deliveryStep,
                driverLocation: driverLocation,
                isMapReady: isMapReady,
              ),
            );
          });
        } else {
          emit(
            state.copyWith(
              driverLocation: driverLocation,
              deliveryStatus: deliveryStep,
              isMapReady: isMapReady,
            ),
          );
        }

        if (currentRouteIndex % 3 == 0) {
          if (state.deliveryStatus == DeliveryStep.outForDelivery) {
            mapController.move(driverLocation, mapController.camera.zoom);
          }
        }
      } else {
        timer.cancel();
      }
    });
  }

  DeliveryStep getDeliveryStep(int routeIndex, int totalPoints) {
    if (routeIndex == 0) return DeliveryStep.confirmed;
    if (routeIndex == 1) return DeliveryStep.packing;
    if (routeIndex < totalPoints - 1) return DeliveryStep.outForDelivery;
    return DeliveryStep.delivered;
  }

  @override
  Future<void> close() {
    simulationTimer?.cancel();
    return super.close();
  }
}
