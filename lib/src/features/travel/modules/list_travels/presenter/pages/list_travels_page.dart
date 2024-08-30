import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/auth_cubit.dart';
import 'package:travelplannerapp/src/features/travel/presenter/travel_info_page.dart';
import 'package:travelplannerapp/src/features/travel/modules/list_travels/presenter/blocs/list_travels_cubit.dart';
import 'package:travelplannerapp/src/features/travel/modules/list_travels/presenter/states/list_travels_state.dart';
import '../../../../../../../core/style/app_style_colors.dart';
import '../../../../../../../core/style/app_style_text.dart';

class ListTravelsPage extends StatefulWidget {
  const ListTravelsPage({super.key});

  @override
  State<ListTravelsPage> createState() => _ListTravelsPageState();
}

class _ListTravelsPageState extends State<ListTravelsPage> {
  final _cubit = GetIt.I.get<ListTravelsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchTravels();
  }

  bool _isInvited(String createdBy) {
    var authCubit = GetIt.I.get<AuthCubit>();
    if (authCubit.state.user != null &&
        authCubit.state.user!.name != createdBy) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _cubit.fetchTravels(),
      child: BlocBuilder<ListTravelsCubit, IListTravelsState>(
        bloc: _cubit,
        builder: (context, state) {
          return switch (state) {
            LoadingListTravelsState() => const Center(
                child: CircularProgressIndicator(),
              ),
            (SuccessListTravelsState successState) => successState
                    .travels.isEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 48),
                      Icon(
                        Icons.travel_explore_outlined,
                        color: AppStyleColors.zinc300,
                        size: 48,
                      ),
                      Center(
                        child: Text(
                          "Nenhuma viagem encontrada",
                          style: AppStyleText.bodyMd(context).copyWith(
                            color: AppStyleColors.zinc300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${successState.travels.length} Viagens",
                        style: AppStyleText.headingSm(context).copyWith(
                          color: AppStyleColors.zinc400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.separated(
                          itemCount: successState.travels.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              color: AppStyleColors.zinc900,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TravelInfoPage(
                                      travel: successState.travels[index],
                                    ),
                                  ),
                                ).then(
                                  (value) {
                                    if (value != null && value == true) {
                                      _cubit.fetchTravels();
                                    }
                                  },
                                );
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.flight,
                                        color: AppStyleColors.lime300,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        successState.travels[index].localName,
                                        style: AppStyleText.bodyMd(context)
                                            .copyWith(
                                          color: AppStyleColors.zinc100,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: _isInvited(
                                        successState.travels[index].createdBy),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppStyleColors.lime300,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Convidado",
                                        style: AppStyleText.bodyMd(context)
                                            .copyWith(
                                          color: AppStyleColors.zinc900,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              subtitle: Column(
                                children: [
                                  Divider(
                                    color: AppStyleColors.zinc800,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: AppStyleColors.zinc500,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "${successState.travels[index].startDate.split('/')[0]}/${successState.travels[index].startDate.split('/')[1]} a ${successState.travels[index].endDate.split('/')[0]}/${successState.travels[index].endDate.split('/')[1]}",
                                        style: AppStyleText.bodySm(context)
                                            .copyWith(
                                                color: AppStyleColors.zinc400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        color: AppStyleColors.zinc500,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "${successState.travels[index].guests!.length} convidado(s)",
                                        style: AppStyleText.bodyMd(context)
                                            .copyWith(
                                                color: AppStyleColors.zinc400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            FailureListTravelsState() => Column(
                children: [
                  const SizedBox(height: 48),
                  Icon(
                    Icons.error_outline,
                    color: AppStyleColors.zinc300,
                    size: 48,
                  ),
                  Center(
                    child: Text(
                      "Ocorreu um problema",
                      style: AppStyleText.bodyMd(context).copyWith(
                        color: AppStyleColors.zinc300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
