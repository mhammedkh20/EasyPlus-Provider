import 'package:easy_plus_service_provider/features/auth/model/user.dart';

class ResponseAuth {
  bool? status;
  bool? unauthorized;
  int? code;
  String? message;
  User? user;

  ResponseAuth({
    this.status,
    this.code,
    this.message,
    this.user,
    this.unauthorized = false,
  });

  ResponseAuth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    unauthorized = false;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  ResponseAuth.fromJsonData(Map<String, dynamic> json) {
    status = json['status'];
    unauthorized = false;
    code = json['code'];
    message = json['message'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  static String getResponseForModel() {
    return """{
    "status": true,
    "code": 200,
    "message": "login successfully",
    "user": {
        "id": 4,
        "name": "test user1",
        "birth_date": "2000-03-08",
        "id_number": "120180073",
        "image": "https://easyplus.app/storage/images/users/AjiBfVpX0J3kV0fU84Hr5b72PQHocSflt3LnOAX8.jpg",
        "phone": "0594569213",
        "email": null,
        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNzUxNDE3MWFmODU4NWQ5ZjY2YzRhNDEwOTZjYzg4Yzc4NmVhYTY0ZWMyMmM1NzAzNDVmY2IxMGNiYjk2ZmViNTI1YWI2MTM5OTZhZTBiY2QiLCJpYXQiOjE2ODIxNzg3OTguNDI5ODcsIm5iZiI6MTY4MjE3ODc5OC40Mjk4NzIsImV4cCI6MTcxMzgwMTE5OC40MjM0OTQsInN1YiI6IjQiLCJzY29wZXMiOlsidXNlciJdfQ.TwiUjdHSFVgf-bzlytvenZjtuQDJjAwx0ioA6Vqc37I4sM8xi3WA3TpK0UeqE2QBfNTTruI2IEJ7h_dUWqFr_E_PqVRDz8hg-Sg1mQpD5oLQwjtSGxg_2xKkoiUqeGcppwZ8bTw13wGtN4uq9HFUnuO6LDDMwuoExoErtl3sqEmLfot8ppTQA9AnmW1qDKabAnuKnM8qUE-nIbU-Hoz0BA0ghGOb4JGdHeORyYOXEW2bRvZtdMOy7sFCd7-B-3na6IeF0zton_PMK5BaBF-vrCHKb8BMWsGHNhy1s5ZCfHGgwyQpsZnptEt2M7AGoTaVr3LNNGMPhYApMC17zvPobsZxekXcHdqB1GGcmlcWbnzm_l1mROHTEEE4YAKBqla32fSqB2JhsyIyK8Bf_hiA8sGguyKWe4z1xmXADQvR9Q_NPe5W1IJ-wB9AOtfL9ypE7fvKZFK1AejqtCskd9D5zBZwG3MHBGXKL6MCBc-AK3VfI1bfXdvNUVnfqsMT3o0Wl50TpmJlwG8CfAwkvKF2uIW-iNE84Mg4_NfJI3gfJE8gDJ6-pNWD9UKYmrM2iT4ZpwNBM5LNGL_GgEYgMyGbIBiBd3tU8DJWXf-ASLUosapf780zv2bNKD3DvRyxPAkOusZw-JZ8QhcQydFWeb9k6rbCOyHzVoWvsXhYOe7dhjg",
        "status": null,
        "gender": "male",
        "wallet_balance": "365.00",
        "orders": []
    }
  }""";
  }
}
