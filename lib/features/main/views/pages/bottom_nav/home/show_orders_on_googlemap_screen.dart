import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/features/main/model/order_object2.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/home/order_details/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;

class ShowOrderOnGoogleMapScreen extends StatefulWidget {
  const ShowOrderOnGoogleMapScreen({super.key});

  @override
  State<ShowOrderOnGoogleMapScreen> createState() =>
      _ShowOrderOnGoogleMapScreenState();
}

class _ShowOrderOnGoogleMapScreenState
    extends State<ShowOrderOnGoogleMapScreen> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> _markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.7251918, 46.8225288),
    zoom: 5,
  );
  @override
  void initState() {
    getOrders(HomeCubit.get(context).listOrder);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.showOrdersOnGoogleMap,
        elevation: 1,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is FailedHomeData) {
            AppHelpers.showSnackBar(
              context,
              message: state.message,
              error: true,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingHomeData) {
            return const LoadingWidget();
          }
          if (state is FailedHomeData) {
            return Center(
              child: lottie.LottieBuilder.asset(
                'assets/images/ic_json/faild.json',
              ),
            );
          }
          if (HomeCubit.get(context).homeResponse == null) {
            return const LoadingWidget();
          }
          return Stack(
            children: [
              GoogleMap(
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _customInfoWindowController.googleMapController = controller;
                },
                onTap: (position) {
                  _customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 200.h,
                width: 300.w,
                offset: 50,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<BitmapDescriptor> setCustomIcons(BuildContext context,
      {required String icon}) async {
    final Uint8List markerIcon = await getBytesFromAsset(icon, 100);

    return BitmapDescriptor.fromBytes(markerIcon);
  }

  Future addLocation({
    required String icon2,
    required String markId,
    required String namePerson,
    required String category,
    required LatLng latLng,
    required int orderId,
  }) async {
    // BitmapDescriptor icon = await setCustomIcons(context, icon: icon2);
    BitmapDescriptor icon = await setCustomIconsNetwork(icon2);
    _markers.add(
      Marker(
          icon: icon,
          markerId: MarkerId(markId),
          position: latLng,
          // infoWindow: InfoWindow(title: category, snippet: namePerson),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              CustomMarker(
                categoryName: category,
                personName: namePerson,
                orderId: orderId,
              ),
              latLng,
            );
          }),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> getBytesFromNetwork(
      String imageUrl, int targetWidth) async {
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(imageUrl);
    final Uint8List markerImageBytes = await markerImageFile.readAsBytes();
    final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
      markerImageBytes,
      targetWidth: targetWidth,
    );
    final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  Future getOrders(List<OrderObject2> listOrder) async {
    for (int i = 0; i < listOrder.length; i++) {
      if (listOrder[i].lat != null && listOrder[i].lng != null) {
        await addLocation(
          latLng: LatLng(listOrder[i].lat!, listOrder[i].lng!),
          namePerson: listOrder[i].user!.name ?? "",
          category: listOrder[i].category ?? "",
          icon2: listOrder[i].categoryIcon ?? "",
          markId: "${(i + 1)}",
          orderId: listOrder[i].id!,
        );
      }
    }
    setState(() {});
  }

  Future<BitmapDescriptor> setCustomIconsNetwork(String imageUrl) async {
    final Uint8List markerIcon = await getBytesFromNetwork(imageUrl, 80);

    return BitmapDescriptor.fromBytes(markerIcon);
  }
}

class CustomMarker extends StatelessWidget {
  final String categoryName;
  final String personName;
  final int orderId;

  const CustomMarker({
    super.key,
    required this.categoryName,
    required this.orderId,
    required this.personName,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      width: 300.w,
      paddingHorizontal: 12,
      bgContainer: AppColors.WHITE.withOpacity(.5),
      paddingVertical: 10,
      borderRadius: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MyText(
                title: '${AppLocalizations.of(context)!.category} : ',
                fontSize: 12,
                color: AppColors.GRAY3,
              ),
              Expanded(child: MyText(title: categoryName)),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              MyText(
                title: '${AppLocalizations.of(context)!.name} : ',
                fontSize: 12,
                color: AppColors.GRAY3,
              ),
              Expanded(child: MyText(title: personName)),
            ],
          ),
          SizedBox(height: 20.h),
          MyElevatedButton(
            title: AppLocalizations.of(context)!.orderDetails,
            onPressed: () {
              AppHelpers.navigationReplacementToPage(
                  context, OrderDetailsScreen(orderId: orderId.toString()));
            },
          ),
        ],
      ),
    );
  }
}
