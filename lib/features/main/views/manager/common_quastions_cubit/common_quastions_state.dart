part of 'common_quastions_cubit.dart';

@immutable
abstract class CommonQuastionsState {}

class CommonQuastionsInitial extends CommonQuastionsState {}

// ! Common Qustion
class LoadingQustionData extends CommonQuastionsState {}

class QustionLoadingPagination extends CommonQuastionsState {}

class FailedQustionData extends CommonQuastionsState {
  final String message;
  FailedQustionData({required this.message});
}

class SuccessQustionData extends CommonQuastionsState {}
