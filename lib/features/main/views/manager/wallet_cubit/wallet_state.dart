part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

// ! opration Wallet
class WalletLoading extends WalletInitial {}

class WalletSuccess extends WalletInitial {
  final String message;
  final int? index;
  final int? id;

  WalletSuccess({required this.message, this.index, this.id});
}

class WalletFailed extends WalletInitial {
  final String message;
  WalletFailed({required this.message});
}
