import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_plus_service_provider/features/main/model/image_model.dart';

class User {
  int? id;
  String? name;
  String? phone;
  String? gender;
  String? idNumber;
  String? licenseNumber;
  String? carModel;
  String? carMake;
  String? year;
  String? carColor;
  String? plateNumber;
  String? birthDate;
  String? image;
  String? idImage;
  String? licenseImage;
  String? carImage;
  String? token;
  String? status;
  num? rate;
  List<ImageModel>? carImages;

  User({
    this.id,
    this.name,
    this.phone,
    this.gender,
    this.idNumber,
    this.licenseNumber,
    this.carModel,
    this.carMake,
    this.year,
    this.carColor,
    this.plateNumber,
    this.birthDate,
    this.image,
    this.idImage,
    this.licenseImage,
    this.carImage,
    this.token,
    this.status,
    this.rate,
    this.carImages,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    idNumber = json['id_number'];
    licenseNumber = json['license_number'];
    carModel = json['car_model'];
    carMake = json['car_make'];
    year = json['year'];
    carColor = json['car_color'];
    plateNumber = json['plate_number'];
    birthDate = json['birth_date'];
    image = json['image'];
    idImage = json['id_image'];
    licenseImage = json['license_image'];
    carImage = json['car_image'];
    token = json['token'];
    status = json['status'];
    rate = json['rate'];
    if (json['car_images'] != null) {
      carImages = [];
      json['car_images'].forEach((v) {
        carImages!.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['id_number'] = idNumber;
    data['license_number'] = licenseNumber;
    data['car_model'] = carModel;
    data['car_make'] = carMake;
    data['year'] = year;
    data['car_color'] = carColor;
    data['plate_number'] = plateNumber;
    data['birth_date'] = birthDate;
    data['image'] = image;
    data['id_image'] = idImage;
    data['license_image'] = licenseImage;
    data['car_image'] = carImage;
    data['token'] = token;
    data['status'] = status;
    data['rate'] = rate;
    if (carImages != null) {
      data['car_images'] = carImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonCarImages() {
    final Map<String, dynamic> data = {};
    data['car_images'] = carImages!.map((v) => v.toJson()).toList();
    return data;
  }

  List<ImageModel>? fromJsonCarImages(String? json) {
    carImages = [];
    if (json != null) {
      Map<String, dynamic> data = jsonDecode(json);

      data['car_images'].forEach((v) {
        carImages!.add(ImageModel.fromJson(v));
      });
    }
    return carImages;
  }

  Future<Map<String, dynamic>> toJsonUpdateUser() async {
    return {
      'name': name,
      'phone': phone,
      'gender': gender,
      'id_number': idNumber,
      'license_number': licenseNumber,
      'car_model': carModel,
      'car_make': carMake,
      'year': year,
      'car_color': carColor,
      'plate_number': plateNumber,
      'birth_date': birthDate,
      if (image != null)
        'image': await MultipartFile.fromFile(
          image!,
          filename: DateTime.now().toString(),
        ),
      if (carImage != null)
        'car_image': await MultipartFile.fromFile(
          carImage!,
          filename: DateTime.now().toString(),
        ),
      if (licenseImage != null)
        'license_image': await MultipartFile.fromFile(
          licenseImage!,
          filename: DateTime.now().toString(),
        ),
      if (idImage != null)
        'id_image': await MultipartFile.fromFile(
          idImage!,
          filename: DateTime.now().toString(),
        ),
    };
  }
}
