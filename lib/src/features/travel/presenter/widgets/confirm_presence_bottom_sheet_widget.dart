import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/components/c_button.dart';
import 'package:travelplannerapp/src/features/travel/modules/guests_travel/presenter/blocs/guest_travel_cubit.dart';

import '../../../../../core/style/app_style_colors.dart';
import '../../../../../core/style/app_style_text.dart';
import '../../modules/guests_travel/presenter/states/guest_travel_state.dart';

class ConfirmPresenceBottomSheetWidget extends StatelessWidget {
  ConfirmPresenceBottomSheetWidget({
    super.key,
    required this.map,
  });

  final Map<String, dynamic> map;

  final _isLoading = ValueNotifier(false);

  final _guestCubit = GetIt.I.get<GuestTravelCubit>();

  void _confirmPresence(bool isAccepted) async {
    _isLoading.value = true;
    await _guestCubit.actionInviteGuest(
      map['guestId'],
      isAccepted ? 'ACCEPT' : 'REJECT',
    );
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _guestCubit,
      listener: (context, state) {
        if (state is SuccessActionInviteGuestTravelListener) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Problema ao realizar ação"),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      listenWhen: (previous, current) => current is IGuestTravelListener,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: AppStyleColors.zinc900,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Confirmar presença",
                  style: AppStyleText.headingMd(context)
                      .copyWith(color: AppStyleColors.zinc100),
                ),
                CloseButton(
                  color: AppStyleColors.zinc100,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Você foi convidado(a) para participar de uma viagem para ${map['localName']} nas datas de ${map['startDate']} a ${map['endDate']}. Confirme sua presença.",
              style: AppStyleText.bodyMd(context)
                  .copyWith(color: AppStyleColors.zinc400),
            ),
            const SizedBox(height: 16),
            Text(
              "Para confirmar sua presença na viagem, clique no botão abaixo.",
              style: AppStyleText.bodySm(context)
                  .copyWith(color: AppStyleColors.zinc400),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: _isLoading,
                  builder: (context, value, child) {
                    return Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        child: CButton(
                          text: 'Recusar',
                          stateTypeButton: _isLoading.value
                              ? StateTypeButton.loading
                              : StateTypeButton.idle,
                          onPressed: () {
                            _confirmPresence(false);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                ValueListenableBuilder(
                  valueListenable: _isLoading,
                  builder: (context, value, child) {
                    return Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        child: CButton(
                          text: 'Confirmar',
                          stateTypeButton: _isLoading.value
                              ? StateTypeButton.loading
                              : StateTypeButton.idle,
                          onPressed: () {
                            _confirmPresence(true);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
