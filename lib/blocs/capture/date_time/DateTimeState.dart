import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DateAndTimeState extends Equatable {
  DateAndTimeState({this.datetime, this.timeOfDay});
  final DateTime? datetime;
  final TimeOfDay? timeOfDay;
  @override
  List get props => [datetime,timeOfDay];
}
