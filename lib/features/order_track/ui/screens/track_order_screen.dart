// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:faker/faker.dart' as faker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';

// 🌎 Project imports:
import 'package:grabber/application/widgets/custom_round_button.dart';
import 'package:grabber/application/widgets/system_ui_wrapper.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/constants/app_styles.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/features/order_track/enum/delivery_step.dart';
import 'package:grabber/features/order_track/ui/screens/cubit/track_order_cubit.dart';
import 'package:grabber/features/order_track/ui/screens/widgets/track_order.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  TrackOrderScreenState createState() => TrackOrderScreenState();
}

class TrackOrderScreenState extends State<TrackOrderScreen> {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    context.read<TrackOrderCubit>().fetchRoute();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      navigationBarColor: AppColors.white,
      navigationBarIconBrightness: Brightness.dark,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: false,
              surfaceTintColor: AppColors.white,
              backgroundColor: AppColors.white,
              expandedHeight: context.screenHeight * 0.55,
              flexibleSpace: FlexibleSpaceBar(background: _buildMapSection()),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildContentSection()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            // Flutter Map
            BlocBuilder<TrackOrderCubit, TrackOrderState>(
              builder: (context, state) {
                return FlutterMap(
                  mapController: mapController,

                  options: MapOptions(
                    initialCenter: state.driverLocation,
                    initialZoom: 13.0,
                    backgroundColor: Color(0xFFF2F2F2),
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    ),
                    onMapReady: () =>
                        context.read<TrackOrderCubit>().startDriverSimulation(
                          mapController: mapController,
                          isMapReady: true,
                        ),
                  ),
                  children: [
                    // Tile Layer (OpenStreetMap)
                    _buildTileLayer(),
                    // Polyline Layer (Delivery Route)
                    if (state.isMapReady)
                      _buildPolyLineLayer(points: state.routePoints),
                    // Marker Layer
                    if (state.isMapReady)
                      _buildMarkLayer(driverLocation: state.driverLocation),
                  ],
                );
              },
            ),
            // Map controls
            _buildMapControls(),
          ],
        ),
      ),
    );
  }

  TileLayer _buildTileLayer() {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.blackcode.grabber',
    );
  }

  Widget _buildPolyLineLayer({required List<LatLng> points}) {
    return PolylineLayer(
      polylines: [
        Polyline(
          points: points,
          strokeWidth: 4.0,
          color: Colors.green,
          pattern: StrokePattern.dashed(segments: [8, 4]),
        ),
      ],
    );
  }

  Widget _buildMarkLayer({required LatLng driverLocation}) {
    return AnimatedMarkerLayer(
      markers: [
        // Store marker
        AnimatedMarker(
          point: TrackOrderCubit.storeLocation,
          width: 40,
          height: 40,
          builder: (_, anim) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(Icons.store, color: Colors.white, size: 20),
          ),
        ),

        // Driver marker
        AnimatedMarker(
          point: driverLocation,
          width: 40,
          height: 40,
          rotate: true,
          builder: (_, anim) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(Icons.motorcycle, color: Colors.white, size: 20),
          ),
        ),

        // Delivery marker
        AnimatedMarker(
          point: TrackOrderCubit.deliveryLocation,
          width: 40,
          height: 40,
          builder: (_, anim) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(Icons.location_on, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    debugPrint('ContentSection');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDeliveryStatus(),
        SizedBox(height: 30),
        Container(
          decoration: AppStyles.boxDecoration,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTrackOrder(),
              const SizedBox(height: 15),
              _buildOrderInfo(),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tip your shopper",
              style: TextStyle(
                color: AppColors.black,
                fontSize: context.textScaler.scale(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Everyone deserve a little kindness",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: context.textScaler.scale(14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomRoundButton(onTap: () {}, text: "\$2.00"),
            CustomRoundButton(onTap: () {}, text: "\$5.00"),
            CustomRoundButton(onTap: () {}, text: "\$10.00"),
            CustomRoundButton(onTap: () {}, text: "\$15.00"),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderInfo() {
    return BlocSelector<TrackOrderCubit, TrackOrderState, DeliveryStep>(
      selector: (state) => state.deliveryStatus,
      builder: (context, state) {
        String orderStatus = '';
        switch (state) {
          case DeliveryStep.packing:
            orderStatus = AppStrings.stillInStore;
            break;
          case DeliveryStep.delivered:
            orderStatus = AppStrings.arrived;
            break;
          case DeliveryStep.outForDelivery:
            orderStatus = AppStrings.comingToYou;
            break;
          default:
            orderStatus = AppStrings.confirmed;
            break;
        }
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(AppImages.user, width: 45, height: 45),
          title: Text(
            faker.faker.person.name(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.textScaler.scale(13),
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                orderStatus,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: context.textScaler.scale(12),
                  color: state == DeliveryStep.delivered
                      ? Colors.green
                      : Colors.grey[600],
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.star, color: AppColors.yellow, size: 13),
              Text(
                "4.5",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filled(
                constraints: BoxConstraints(),
                visualDensity: VisualDensity.standard,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                ),
                onPressed: () {},
                icon: Icon(Icons.message_outlined),
                color: AppColors.black,
                iconSize: 14,
              ),
              IconButton.filled(
                constraints: BoxConstraints(),
                visualDensity: VisualDensity.standard,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                ),
                onPressed: () {},
                icon: Icon(Icons.call_outlined),
                color: AppColors.black,
                iconSize: 14,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrackOrder() {
    return BlocBuilder<TrackOrderCubit, TrackOrderState>(
      builder: (context, state) {
        if (!state.isMapReady) {
          return TrackOrder(currentStep: DeliveryStep.confirmed);
        }
        DeliveryStep currentStep = state.deliveryStatus;
        return TrackOrder(currentStep: currentStep);
      },
    );
  }

  Widget _buildDeliveryStatus() {
    return BlocSelector<TrackOrderCubit, TrackOrderState, DeliveryStep>(
      selector: (state) => state.deliveryStatus,
      builder: (context, state) {
        String step = '';
        switch (state) {
          case DeliveryStep.confirmed:
            step = AppStrings.confirmed;
            break;
          case DeliveryStep.packing:
            step = AppStrings.packingYourOrders;
            break;
          case DeliveryStep.outForDelivery:
            step = AppStrings.outForDelivery;
            break;
          case DeliveryStep.delivered:
            step = AppStrings.yourOrderHasArrived;
            break;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  state == DeliveryStep.delivered
                      ? "${faker.faker.person.name()}${AppStrings.isWattingOutside}"
                      : "Arriving at 12:00",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            if (state == DeliveryStep.packing)
              Lottie.asset(AppImages.cart, width: 62, height: 62),
            if (state == DeliveryStep.outForDelivery ||
                state == DeliveryStep.delivered)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    faker.faker.randomGenerator.numberOfLength(4),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    AppStrings.yourCode,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildMapControls() {
    debugPrint('MapControls');
    return BlocBuilder<TrackOrderCubit, TrackOrderState>(
      builder: (context, state) {
        return Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                heroTag: 'zoomIn',
                backgroundColor: Colors.white,
                foregroundColor: Colors.black54,
                onPressed: () {
                  mapController.move(
                    mapController.camera.center,
                    mapController.camera.zoom + 1,
                  );
                },
                child: Icon(Icons.add),
              ),
              SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'zoomOut',
                mini: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black54,
                onPressed: () {
                  mapController.move(
                    mapController.camera.center,
                    mapController.camera.zoom - 1,
                  );
                },
                child: Icon(Icons.remove),
              ),
              SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'center',
                mini: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black54,
                onPressed: () {
                  // Center on driver location
                  mapController.move(state.driverLocation, 15.0);
                },
                child: Icon(Icons.my_location),
              ),
            ],
          ),
        );
      },
    );
  }
}
