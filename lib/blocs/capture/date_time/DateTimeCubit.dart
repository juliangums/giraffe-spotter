import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/capture/date_time/DateTimeState.dart';

class DateAndTimeCubit extends Cubit<DateAndTimeState> {

  DateTime? copyWithTime;
  TimeOfDay? timeOfDays;
  DateAndTimeCubit() : super(DateAndTimeState());

  void setDateTime(datetime) {
    copyWithTime = datetime;
    emit(DateAndTimeState(datetime: datetime));
  }

  void setTimeOfDay(timeOfDay) {
    timeOfDays = timeOfDay;
    emit(DateAndTimeState(timeOfDay: timeOfDay));
  }

  void reset(){
    copyWithTime = null;
    timeOfDays = null;
  }

  formatTime(TimeOfDay? input) {
    var hour =  input!.hour.toString();
    var minute = input.minute.toString();
    var period = input.period.toString() == 'DayPeriod.am' ? "am" : "pm";

    var minutes = minute.length <= 1 ? "0"+ minute : minute;
    if(int.parse(hour) > 11 ) {
      return hour +":"+minutes;
    }
     return hour +":"+ minutes+" "+ period;
  }
}
