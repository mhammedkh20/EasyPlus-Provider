part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
// ! App Config States

class LoadingGetAppConfig extends HomeState {}

class FailedGetAppConfig extends HomeState {
  final String message;
  FailedGetAppConfig({required this.message});
}

class SuccessGetAppConfig extends HomeState {}

// ! home data States
class LoadingHomeData extends HomeState {}

class HomeLoadingPagination extends HomeState {}

class FailedHomeData extends HomeState {
  final String message;
  FailedHomeData({required this.message});
}

class SuccessHomeData extends HomeState {}
