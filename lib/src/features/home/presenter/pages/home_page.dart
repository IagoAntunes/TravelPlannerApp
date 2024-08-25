import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/src/features/create_travel/presenter/pages/create_travel_page.dart';
import 'package:travelplannerapp/src/features/home/presenter/blocs/home_cubit.dart';
import 'package:travelplannerapp/src/features/list_travels/presenter/pages/list_travels_page.dart';

import '../../../../../core/style/app_style_colors.dart';
import '../../../../../core/style/app_style_text.dart';
import '../../../auth/presenter/blocs/auth_cubit.dart';
import '../states/home_state.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _cubit = GetIt.I.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, IHomeState>(
          bloc: _cubit,
          builder: (context, state) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('assets/images/planner_logo.png'),
                    ),
                    Text(
                      "Abaixo estão as viagens que você está participando",
                      style: AppStyleText.bodyLg(context).copyWith(
                        color: AppStyleColors.zinc400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CButton.icon(
                        text: state.homeModuleType == HomeModuleType.listTravels
                            ? "Criar nova viagem"
                            : "Listar Viagens",
                        onPressed: () {
                          _cubit.changeHomeModuleType();
                        },
                        icon: state.homeModuleType == HomeModuleType.listTravels
                            ? Icons.add
                            : Icons.flight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: AppStyleColors.zinc800,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: switch (state.homeModuleType) {
                          HomeModuleType.listTravels => const ListTravelsPage(),
                          HomeModuleType.createTravel => CreateTravelPage(),
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
