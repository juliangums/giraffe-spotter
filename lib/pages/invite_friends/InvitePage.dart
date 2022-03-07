import 'package:flutter/material.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        title: 'Invite Friends',
        leading: ArrowBackButton(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(height:20),
              Center(child: Text("Invite Friends page coming soon.")),
            ],
          ),
        ));
  }
}
