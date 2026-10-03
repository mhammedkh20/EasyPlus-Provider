import 'package:easy_plus_service_provider/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        int index = MainCubit.get(context).indexPageNav;
        return MainCubit.get(context).getPage(context)[index].widget;
      },
    );
  }
}
