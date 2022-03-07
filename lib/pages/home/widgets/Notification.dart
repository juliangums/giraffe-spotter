import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Styles.dart';


class NotificationTile extends StatelessWidget{

  final String feedback;
  final String description;
  final String image;
  final bool status;
  final String time;

  NotificationTile({required this.time,required this.description,required this.feedback,required this.image, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            feedback,
            style: Styles.dataText,
          ),
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: Text(
              time,
              style: Styles.notificationText,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      subtitle: Text(
        description,
        style: Styles.notificationText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: Container(
        margin: EdgeInsets.only(left: 22),
        height: 42,
        width: 42,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(5)),
      )
    );
  }

}
