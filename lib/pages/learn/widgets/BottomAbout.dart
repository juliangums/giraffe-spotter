import 'package:flutter/cupertino.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/Styles.dart';

import 'Park.dart';

class BottomAbout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 29),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Explore By Region",
                style: Styles.regionsHeading,
              )
            ],
          ),
          LimitedBox(
            maxHeight: 225,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: Constants.regions.length,
                itemBuilder: (context, index) {
                  final region = Constants.regions[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Region(
                      title: region.title,
                    ),
                  );
                }),
          ),
          LimitedBox(
            maxHeight: 225,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: Constants.parks.length,
                itemBuilder: (context, index) {
                  final park = Constants.parks[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Park(
                      park: park.park,
                      country: park.country,
                      flag: park.flag,
                    ),
                  );
                }),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

}