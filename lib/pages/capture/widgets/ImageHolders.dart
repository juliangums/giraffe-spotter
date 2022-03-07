import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class ImageHolder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Container(
      height: height/3.3,
      width: width/1.17,
      //padding: EdgeInsets.only(left:20.0,right: 20.0),
      child: GridView.builder(
          itemCount: 2,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //number of child widget
              crossAxisCount: 2,
              // mainAxisSpacing: 10.0,
              crossAxisSpacing: 23.0,
              //size of the container
              childAspectRatio: 0.86
          ),
          itemBuilder: (BuildContext context, int index)
          {
            return Container(decoration:  new BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage(
                        index == 1 ?
                        Assets.giraffeTwo :
                        Assets.giraffeOne
                      ),
                      fit: BoxFit.fill
                  ),
                  color: Palette.containerShade,
                  borderRadius: new BorderRadius.only(
                    topRight: const Radius.circular(10.0),
                    topLeft: const Radius.circular(10.0),
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0),
                  )
              ));
          }
      ),
    );
  }

}