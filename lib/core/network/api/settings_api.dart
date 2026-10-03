// ignore_for_file: constant_identifier_names

class SittingsApi {
  static const String BASE_URL = 'http://5ways.com.sa/api/';
  // ! Auth
  static const String REGISTR = '${BASE_URL}partners/register';
  static const String LOGIN = '${BASE_URL}partners/login';
  static const String VERIFY_CODE = '${BASE_URL}partners/verify-code';
  static const String FORGET_PASSWORD = '${BASE_URL}partners/forget-password';
  static const String RESET_PASSWORD = '${BASE_URL}partners/reset-password';
  static const String CHANGE_PASSWORD = '${BASE_URL}partners/change-password';
  static const String LOGOUT = '${BASE_URL}partners/logout';
  static const String UPDATE_ACCOUNT = '${BASE_URL}partners/update-profile';
  static const String UPDATE_SERVICES = '${BASE_URL}partners/select-services';
  static const String PROFILE_ACCOUNT = '${BASE_URL}partners/profile';

  // ! Update Location
  static const String UPDATE_LOCATION = '${BASE_URL}partners/update-location';

  // ! Home With slider
  static const String HOME = '${BASE_URL}partners/home';

  // ! Side Bar
  static const String CONTACT_US = '${BASE_URL}partners/contact-us';
  static const String NOTIFICATION = '${BASE_URL}partners/notifications';

  // ! Orders
  static const String GET_SHOW_ORDER_IDS = '${BASE_URL}partners/showOrderIds';
  static const String GET_MY_OFFER = '${BASE_URL}partners/offers?status=';
  static const String GET_DETAILS_ORDER = '${BASE_URL}partners/showOrder/';
  static const String MACK_OFFER = '${BASE_URL}partners/make-offer';
  static const String CANCLE_ORDER = '${BASE_URL}partners/cancelByDriver/';

  // ! On Boarding
  static const String SHOW_LOGIN_METHOD = '${BASE_URL}showLoginMethods';

  // ! App Config
  static const String APP_CONFIG = '${BASE_URL}partners/app';

  // ! Wallet
  static const String PULL_REQUEST = '${BASE_URL}partners/pull-request';
  static const String GET_WALLET = '${BASE_URL}partners/wallet';
  static const String REQUEST_BALANCE = '${BASE_URL}partners/request-money';
  static const String ADD_BALANCE = '${BASE_URL}partners/add-balance';

  // ! Complaints
  static const String COMPLAINTS = '${BASE_URL}partners/complaints';
  static const String COMMON_QUSTION = '${BASE_URL}partners/common-quastions';

  // ! Privacy Policy
  static const String PRIVACY_POLICY = '${BASE_URL}partners/privacy-policy';
  static const String TERMS_OF_USE = '${BASE_URL}users/terms_of_use';
}
