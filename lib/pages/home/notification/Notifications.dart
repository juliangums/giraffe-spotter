import 'package:flutter/material.dart';
import 'package:giraffe_spotter/blocs/notification/notification_cubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/home/notification/NotificationStatus.dart';
import 'package:giraffe_spotter/pages/home/widgets/Notification.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Notifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(notifications: false),
      child: PageWrapper(
          title: "Notifications",
          leading: ArrowBackButton(),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today",
                          style: Styles.notificationDayText,
                        ),
                        GestureDetector(
                          onTap: () => context.read<NotificationCubit>().changeBool(true),
                          child: Text(
                            "Clear",
                            style: Styles.clearTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<NotificationCubit,bool >(
                    builder: (context, state) {
                      return LimitedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount:  context.read<NotificationCubit>().notifications ? 1:Constants.notifications.length ,
                            itemBuilder: (context, index) {
                              final notification = Constants.notifications[index];
                              if(context.read<NotificationCubit>().notifications) return Padding(
                                  padding: EdgeInsets.only(top:10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("No Notifications found.",
                                      style: Styles.notificationDayText.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              if (index == 5) return Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 12, 0, 12),
                                  child: Row(
                                      children: [
                                        SizedBox(width: 12),
                                        Text('Yesterday',
                                            style: Styles.notificationDayText)
                                      ]
                                  ),
                                );
                              return InkWell(
                                key: Key('notifications${index.toString()}'),
                                onTap: () {
                                  locator!<AppRoute>().navigateTo(
                                      NotificationStatus(
                                        image: notification.image,
                                        description: notification.description,
                                        status: notification.status,
                                        feedback: notification.feedback,
                                      ));
                                },
                                child: Column(
                                  children: [
                                    NotificationTile(
                                      image: notification.image,
                                      time: notification.time,
                                      feedback: notification.feedback,
                                      description: notification.description,
                                      status: false,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      indent: 10,
                                      endIndent: 90,
                                      color: Colors.grey[200],
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ],
              )),
        ),
    );
  }
}
