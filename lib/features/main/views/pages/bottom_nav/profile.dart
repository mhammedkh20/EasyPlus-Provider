import 'dart:io';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/custom_dropdown_menu.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text_field.dart';
import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:easy_plus_service_provider/features/main/model/image_model.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/profile/pick_images_for_user.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/profile/header_profile.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _keyForm = GlobalKey<FormState>();

  final TextEditingController _datePickerController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _publicationYearController =
      TextEditingController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _typeOfCarController = TextEditingController();

  @override
  void initState() {
    User? user = MyAccountCubit.get(context).userData;
    if (user != null) {
      print(user.gender);
      MyAccountCubit.get(context).changeGenderUser(user.gender! == ''
          ? 3
          : user.gender == 'male'
              ? 1
              : 2);
      _nameController.text = user.name ?? "";
      _phoneController.text = user.phone ?? "";
      _idNumberController.text = user.idNumber ?? "";
      _licenseNumberController.text = user.licenseNumber ?? "";
      _vehicleModelController.text = user.carModel ?? "";
      _publicationYearController.text = user.year ?? "";
      _plateNumberController.text = user.plateNumber ?? "";
      _typeOfCarController.text = user.carModel ?? "";
      _datePickerController.text = user.birthDate ?? "";
      if (user.carImage != null) {
        MyAccountCubit.get(context).listCars.clear();
        MyAccountCubit.get(context).listCars.addAll(user.carImages ?? []);
      }
    }
    super.initState();
  }

  @override
  void deactivate() {
    MyAccountCubit.get(context).picked = false;
    MyAccountCubit.get(context).pickedIdPhoto = false;
    MyAccountCubit.get(context).pickedLicense = false;
    MyAccountCubit.get(context).pickedVehicleImage = false;

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderProfile(),
        SizedBox(height: 20.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    SizedBox(height: 22.h),
                    MyTextField(
                      controller: _nameController,
                      textHint: '',
                      labelText: AppLocalizations.of(context)!.name,
                      isBorder: true,
                      fontSize: 16,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterYourUsername;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textHint: '',
                      labelText: AppLocalizations.of(context)!.phoneNumber,
                      isBorder: true,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterYourPhoneNumber;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    CustomDropdownMenu<String>(
                      initValue: MyAccountCubit.get(context).indexSelected == 1
                          ? AppLocalizations.of(context)!.male
                          : MyAccountCubit.get(context).indexSelected == 2
                              ? AppLocalizations.of(context)!.female
                              : AppLocalizations.of(context)!.pleaseSpecify,
                      listItems: [
                        AppLocalizations.of(context)!.pleaseSpecify,
                        AppLocalizations.of(context)!.male,
                        AppLocalizations.of(context)!.female
                      ],
                      notify: true,
                      isExpanded: true,
                      alignment: AlignmentDirectional.centerStart,
                      onChanged: <String>(String? enabled) {
                        if (AppLocalizations.of(context)!.male == enabled) {
                          MyAccountCubit.get(context).changeGenderUser(1);
                        } else {
                          MyAccountCubit.get(context).changeGenderUser(2);
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _idNumberController,
                      textHint: '',
                      keyboardType: TextInputType.number,
                      labelText: AppLocalizations.of(context)!.idNumber,
                      isBorder: true,
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _licenseNumberController,
                      textHint: '',
                      keyboardType: TextInputType.number,
                      labelText: AppLocalizations.of(context)!.licenseNumber,
                      isBorder: true,
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _vehicleModelController,
                      textHint: '',
                      keyboardType: TextInputType.number,
                      labelText: AppLocalizations.of(context)!.vehicleModel,
                      isBorder: true,
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _publicationYearController,
                      textHint: '',
                      keyboardType: TextInputType.number,
                      labelText: AppLocalizations.of(context)!.publicationYear,
                      isBorder: true,
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _plateNumberController,
                      textHint: '',
                      labelText: AppLocalizations.of(context)!.plateNumber,
                      isBorder: true,
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _typeOfCarController,
                      textHint: '',
                      labelText: AppLocalizations.of(context)!.typeOfCar,
                      isBorder: true,
                    ),
                    SizedBox(height: 24.h),
                    MyTextField(
                      controller: _datePickerController,
                      labelText: AppLocalizations.of(context)!.dateOfBirth,
                      textHint: '',
                      filledColor: true,
                      onTap: () async {
                        String? date = await AppHelpers.selectDate(context);
                        _datePickerController.text = date ?? "";
                      },
                      isBorder: true,
                      readOnly: true,
                    ),
                    SizedBox(height: 35.h),
                    const PickImagesForUser(),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/ic_pick_image.svg',
                          width: 22.w,
                        ),
                        SizedBox(width: 5.w),
                        MyText(
                          title: AppLocalizations.of(context)!.vehicleImage,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 70.r,
                      child: BlocBuilder<MyAccountCubit, MyAccountState>(
                        builder: (context, state) {
                          if (MyAccountCubit.get(context).listCars.length ==
                              0) {
                            return Material(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.GRAY2.withOpacity(.1),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  MyAccountCubit.get(context)
                                      .pickVehicleImage();
                                },
                                child: MyContainerShape(
                                  width: double.infinity,
                                  height: double.infinity,
                                  borderRadius: 8,
                                  bgContainer: AppColors.TRANSPARENT,
                                  child: MyText(
                                    title: AppLocalizations.of(context)!
                                        .choosePhotosVehicle,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: MyAccountCubit.get(context)
                                        .listCars
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return MyContainerShape(
                                        height: 70.r,
                                        width: 80.r,
                                        borderRadius: 4,
                                        marginEnd: 8.w,
                                        child: Stack(
                                          children: [
                                            if (MyAccountCubit.get(context)
                                                .listCars[index]
                                                .isDevice!)
                                              Image.file(
                                                File(
                                                  MyAccountCubit.get(context)
                                                      .listCars[index]
                                                      .image!,
                                                ),
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              )
                                            else
                                              Image.network(
                                                MyAccountCubit.get(context)
                                                    .listCars[index]
                                                    .image!,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            GestureDetector(
                                                onTap: () {
                                                  MyAccountCubit.get(context)
                                                      .deleteCarImage(index);
                                                },
                                                child: Icon(Icons.close)),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    if (MyAccountCubit.get(context)
                                            .listCars
                                            .length <
                                        5) {
                                      MyAccountCubit.get(context)
                                          .pickVehicleImage();
                                    } else {
                                      AppHelpers.showSnackBar(context,
                                          message: AppLocalizations.of(context)!
                                              .maximumNumberVehicle5,
                                          error: true);
                                    }
                                  },
                                  child: MyContainerShape(
                                    width: 70.r,
                                    borderRadius: 10,
                                    enableBorder: true,
                                    height: 70.r,
                                    child: Icon(Icons.add),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 40.h),
                    BlocConsumer<MyAccountCubit, MyAccountState>(
                      listener: (context, state) {
                        if (state is UpdateUserSuccess) {
                          AppHelpers.showSnackBar(context,
                              message: state.message);
                        }
                        if (state is UpdateUserFailed) {
                          AppHelpers.showSnackBar(
                            context,
                            message: state.message,
                            error: true,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdateUserLoading) {
                          return const LoadingWidget();
                        }
                        return MyElevatedButton(
                          title:
                              AppLocalizations.of(context)!.saveTheModification,
                          onPressed: () async {
                            if (_keyForm.currentState!.validate()) {
                              List<ImageModel>? cars;
                              if (MyAccountCubit.get(context).listCars.length >
                                  0) {
                                cars = [];
                                for (int i = 0;
                                    i <
                                        MyAccountCubit.get(context)
                                            .listCars
                                            .length;
                                    i++) {
                                  if (MyAccountCubit.get(context)
                                      .listCars[i]
                                      .isDevice!) {
                                    cars.add(MyAccountCubit.get(context)
                                        .listCars[i]);
                                  }
                                }
                              }
                              int indexGender =
                                  MyAccountCubit.get(context).indexSelected;
                              await MyAccountCubit.get(context).updateUser(
                                context,
                                user: User(
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  idNumber: _idNumberController.text.trim(),
                                  birthDate: _datePickerController.text.trim(),
                                  licenseNumber:
                                      _licenseNumberController.text.trim(),
                                  carModel: _typeOfCarController.text.trim(),
                                  year: _publicationYearController.text.trim(),
                                  plateNumber:
                                      _plateNumberController.text.trim(),
                                  gender: indexGender == 1
                                      ? "male"
                                      : indexGender == 2
                                          ? "female"
                                          : null,
                                  image: MyAccountCubit.get(context).pathImage,
                                  // carImage:
                                  //     MyAccountCubit.get(context).vehicleImage,
                                  idImage: MyAccountCubit.get(context).idPhoto,
                                  licenseImage:
                                      MyAccountCubit.get(context).licenseImage,
                                  carImages: cars == null
                                      ? null
                                      : cars.length == 0
                                          ? null
                                          : cars,
                                ),
                              );
                            }
                          },
                          titleColor: AppColors.BLACK,
                        );
                      },
                    ),
                    SizedBox(height: 70.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
