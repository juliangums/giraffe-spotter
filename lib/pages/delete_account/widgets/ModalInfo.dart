import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/authentication/logout/LogoutCubit.dart';
import 'package:giraffe_spotter/blocs/home/BottomBarCubit.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class ModalInfo extends StatefulWidget {
  const ModalInfo({Key? key,required this.select, required this.context}) : super(key: key);


  final BuildContext context;
  final bool select;

  @override
  _ModalInfo createState() => _ModalInfo();
}

class _ModalInfo extends State<ModalInfo> {
  bool _visible = false;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  _startTimer() {
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(height: height / 4, width: width),
          child: widget.select == true ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Account deleted', style: Styles.confirmDeleteTopic),
              SizedBox(height: 13),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: 'W', style: Styles.confirmDeleteW),
                  TextSpan(
                      text: 'e’re sorry to see you leave. You’re  \nalways welcome to join Giraffe \n Spotter again.',
                      style: Styles.confirmDeleteNote)
                ]),
              ),
              SizedBox(height: 29),
              Container(
                child: Center(
                  child: Text(
                      'Exit',style: Styles.onBoardNext
                  ),
                ),
                height: 53,
                width: 120,
                decoration: BoxDecoration(
                  color: Palette.accentColor,
                  borderRadius:BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Come back soon!", style: Styles.comeBackSoon),
              Text("Are you sure you want to log out?", style: Styles.logQuery),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text('Cancel', style: Styles.cancelModal),
                  SizedBox(width: 30),
                  GestureDetector (
                    onTap: () {
                      BlocProvider.of<BottomBarCubit>(context).updateIndex(0);
                      context.read<LogoutCubit>().logout();
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                            'Logout',style: Styles.onBoardNext
                        ),
                      ),
                      height: 53,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Palette.accentColor,
                        borderRadius:BorderRadius.all(Radius.circular(10)),
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
