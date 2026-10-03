part of 'my_request_cubit.dart';

@immutable
abstract class MyRequestState {}

class MyRequestInitial extends MyRequestState {}

//! Get My Offers

class MyOfferLoading extends MyRequestState {}

class MyOfferLoadingPagination extends MyRequestState {}

class MyOfferSuccess extends MyRequestState {
  final String message;
  MyOfferSuccess({required this.message});
}

class MyOfferFailed extends MyRequestState {
  final String message;
  MyOfferFailed({required this.message});
}

//! Get OrderDetails
class OrderDetailsLoading extends MyRequestState {}

class OrderDetailsSuccess extends MyRequestState {
  final String message;
  OrderDetailsSuccess({required this.message});
}

class OrderDetailsFailed extends MyRequestState {
  final String message;
  OrderDetailsFailed({required this.message});
}

//! Mack Offer
class MackOfferLoading extends MyRequestState {}

class MackOfferSuccess extends MyRequestState {
  final String message;
  MackOfferSuccess({required this.message});
}

class MackOfferFailed extends MyRequestState {
  final String message;
  MackOfferFailed({required this.message});
}

//! Cancel Order
class CancelLoading extends MyRequestState {}

class CancelSuccess extends MyRequestState {
  final String message;
  CancelSuccess({required this.message});
}

class CancelFailed extends MyRequestState {
  final String message;
  CancelFailed({required this.message});
}
