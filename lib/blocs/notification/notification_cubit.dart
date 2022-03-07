import 'package:bloc/bloc.dart';


class NotificationCubit extends Cubit<bool> {
  bool notifications;

  NotificationCubit({required this.notifications}) : super(notifications);

  changeBool(bool changer){
    notifications = changer;
    emit(changer);
  }
}
