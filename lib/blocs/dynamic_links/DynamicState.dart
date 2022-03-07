part of 'DynamicCubit.dart';

class DynamicState extends Equatable{

  final FormzStatus status;
  final String? route;
  final String? data;
  final Uri? shorturl;
  final bool? home;

  const DynamicState({
    this.status = FormzStatus.pure,
    this.home = false,
    this.route,
    this.data,
    this.shorturl,
  });

  @override
  List<Object?> get props => [ status,route,shorturl,data,home];

  DynamicState copyWith({FormzStatus? status,bool? home, String? route,String? data, Uri? shorturl}) => DynamicState(data: data,  status:  status ?? this.status, route: route, shorturl: shorturl, home: home);

}
