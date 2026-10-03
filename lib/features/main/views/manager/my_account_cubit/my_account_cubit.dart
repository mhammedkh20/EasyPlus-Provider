import 'dart:developer';

import 'package:easy_plus_service_provider/features/main/model/image_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/features/auth/data/auth_repo_imp.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final AuthRepoImp _authRepoImp = AuthRepoImp();

  MyAccountCubit() : super(MyAccountInitial());

  static MyAccountCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  final ImagePicker _picker = ImagePicker();
  User? userData;

  getUserDataFromShared() async {
    userData = SharedPrefController().getDataUser();
    if (userData!.id == -1) {
      userData = null;
      return;
    }
  }

  int indexSelected = -1;
  changeGenderUser(int index) {
    indexSelected = index;
    emit(MyAccountInitial());
  }

  int genderSelected = -1;
  changeGender(int index) {
    genderSelected = index;
    emit(MyAccountInitial());
  }

  String? pathImage;
  bool picked = false;

  Future pickImageUser() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pathImage = image.path;
      picked = true;

      emit(MyAccountInitial());
    }
  }

  bool pickedIdPhoto = false;
  String? idPhoto;
  Future pickIdPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      idPhoto = image.path;
      pickedIdPhoto = true;
      emit(MyAccountInitial());
    }
  }

  String? licenseImage;
  bool pickedLicense = false;

  Future pickLicenseImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      licenseImage = image.path;
      pickedLicense = true;
      emit(MyAccountInitial());
    }
  }

  // String? vehicleImage;
  // bool pickedVehicleImage = false;

  // Future pickVehicleImage() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     vehicleImage = image.path;
  //     pickedVehicleImage = true;
  //     emit(MyAccountInitial());
  //   }
  // }
  List<ImageModel> listCars = [];
  bool pickedVehicleImage = false;

  Future pickVehicleImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedVehicleImage = true;
      listCars.add(
        ImageModel(id: listCars.length, image: image.path, isDevice: true),
      );

      emit(MyAccountInitial());
    }
  }

  deleteCarImage(int index) async {
    listCars.removeAt(index);
    emit(MyAccountInitial());
  }

  Future updateUser(BuildContext context, {required User user}) async {
    emit(UpdateUserLoading());

    ResponseAuth? responseUpdateUser =
        await _authRepoImp.updateAccount(user: user);

    if (responseUpdateUser != null && responseUpdateUser.status!) {
      userData = responseUpdateUser.user!;
      if (userData!.carImages != null) {
        log(userData!.carImages!.length.toString());
      }
      picked = false;
      log(userData!.idImage.toString());
      log(userData!.carImage.toString());
      log(userData!.licenseImage.toString());

      await SharedPrefController().saveDataUser(responseUpdateUser.user!);
      emit(UpdateUserSuccess(message: responseUpdateUser.message!));
    }

    if (responseUpdateUser == null) {
      emit(
        UpdateUserFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseUpdateUser.status!) {
      emit(UpdateUserFailed(message: responseUpdateUser.message!));
    }
  }
}
