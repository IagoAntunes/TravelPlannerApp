import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/services/notification/domain/model/custom_notification.dart';
import 'package:travelplannerapp/src/features/travel/modules/create_travel/presenter/pages/create_travel_page.dart';
import 'package:travelplannerapp/src/features/home/presenter/blocs/home_cubit.dart';
import 'package:travelplannerapp/src/features/travel/modules/list_travels/presenter/pages/list_travels_page.dart';

import '../../../../../core/style/app_style_colors.dart';
import '../../../../../core/style/app_style_text.dart';
import '../../../../../services/notification/notification_service.dart';
import '../../../auth/presenter/blocs/auth_cubit.dart';
import '../states/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cubit = GetIt.I.get<HomeCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        FirebaseMessaging messaging = FirebaseMessaging.instance;

        await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      },
    );
    checkNotifications();
    super.initState();
  }

  void checkNotifications() async {
    var notification = GetIt.I.get<NotificationService>();
    notification.checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var notification = GetIt.I.get<NotificationService>();
          notification.showNotificationSchedule(
            CustomNotification(
              id: 1,
              body: 'Ola',
              payload: 'Payload',
              title: 'Title,',
            ),
          );
          // final fcmToken = await FirebaseMessaging.instance.getToken();
          // print(fcmToken);
        },
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, IHomeState>(
          bloc: _cubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/planner_logo.png'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GetIt.I.get<AuthCubit>().logout();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: AppStyleColors.zinc400,
                        ),
                      ),
                    ],
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
                        HomeModuleType.createTravel => const CreateTravelPage(),
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
