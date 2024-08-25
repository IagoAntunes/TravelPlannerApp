import 'package:flutter/material.dart';
import '../../../../../core/style/app_style_colors.dart';
import '../../../../../core/style/app_style_text.dart';

class ListTravelsPage extends StatelessWidget {
  const ListTravelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "7 Viagens",
          style: AppStyleText.headingSm(context).copyWith(
            color: AppStyleColors.zinc400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: AppStyleColors.zinc900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.flight,
                      color: AppStyleColors.lime300,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Viagem",
                      style: AppStyleText.bodyMd(context).copyWith(
                        color: AppStyleColors.zinc100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                          Icons.location_on,
                          color: AppStyleColors.zinc500,
                        ),
                        Text(
                          "Florianopolis,",
                          style: AppStyleText.bodyMd(context)
                              .copyWith(color: AppStyleColors.zinc400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: AppStyleColors.zinc500,
                        ),
                        Text(
                          "17 a 23 de ago,",
                          style: AppStyleText.bodySm(context)
                              .copyWith(color: AppStyleColors.zinc400),
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
    );
  }
}
