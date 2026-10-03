part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

// ! State Update Service
class UpdateServiceLoading extends SettingsState {}

class UpdateServiceSuccess extends SettingsState {
  final String message;
  UpdateServiceSuccess({required this.message});
}

class UpdateServiceFailed extends SettingsState {
  final String message;
  UpdateServiceFailed({required this.message});
}

// ! State Contact Us
class ContactUsLoading extends SettingsState {}

class ContactUsSuccess extends SettingsState {
  final String message;
  ContactUsSuccess({required this.message});
}

class ContactUsFailed extends SettingsState {
  final String message;
  ContactUsFailed({required this.message});
}

// ! State Request Money
class PullRequestLoading extends SettingsState {}

class PullRequestSuccess extends SettingsState {
  final String message;
  PullRequestSuccess({required this.message});
}

class PullRequestFailed extends SettingsState {
  final String message;
  PullRequestFailed({required this.message});
}

// ! State Privacy Policy
class PrivacyPolicyLoading extends SettingsState {}

class PrivacyPolicySuccess extends SettingsState {
  final String message;
  PrivacyPolicySuccess({required this.message});
}

class PrivacyPolicyFailed extends SettingsState {
  final String message;
  PrivacyPolicyFailed({required this.message});
}

// ! opration Change Password
class ChangePasswordLoading extends SettingsState {}

class ChangePasswordSuccess extends SettingsState {
  final String message;
  ChangePasswordSuccess({required this.message});
}

class ChangePasswordFailed extends SettingsState {
  final String message;
  ChangePasswordFailed({required this.message});
}

class BalanceLoading extends SettingsState {}

class BalanceSuccess extends SettingsState {
  final String message;
  final int? id;

  BalanceSuccess({required this.message, this.id});
}

class BalanceFailed extends SettingsState {
  final String message;
  BalanceFailed({required this.message});
}

// ! Notification
class NotificationsLoading extends SettingsState {}

class NotificationsFailed extends SettingsState {
  final String message;
  NotificationsFailed({required this.message});
}

class NotificationsSuccess extends SettingsState {}
