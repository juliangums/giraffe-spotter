import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';

class AnimatedIconContent extends StatefulWidget{
  final bool deletePage;
  const AnimatedIconContent({Key? key, required this.deletePage}):super(key: key);

 @override
  _DeleteIcon createState()=> _DeleteIcon();
}

class _DeleteIcon extends State<AnimatedIconContent> with SingleTickerProviderStateMixin {

  AnimationController? controller;

  late Animation<double> offsetAnimation =  Tween(begin: 0.0, end:24.0).chain(
      CurveTween(curve: Curves.elasticIn)).animate(controller!)..addStatusListener((status){
    if(status == AnimationStatus.completed)
    {
      controller!.reverse();
    }
  });


  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 600),vsync: this);
    startTimer();
    super.initState();
  }

  //timer
  startTimer()
  {
    Future.delayed(Duration(microseconds: 1200), () {
      controller!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: offsetAnimation, builder: (context,child){
         return Container(
           margin: EdgeInsets.symmetric(horizontal: 24),
           padding: widget.deletePage == true? EdgeInsets.only(left: offsetAnimation.value +30.0,right: 30.0 -offsetAnimation.value ): EdgeInsets.only(top: offsetAnimation.value +20.0,),
           child: GestureDetector(
             onTap: ()=> controller!.forward(),
             child: widget.deletePage == true ? SvgPicture.asset(Assets.trash) :  Image.asset(Assets.marker, width: 25, height: 30),
           ),
         );
    }
    );
  }

}