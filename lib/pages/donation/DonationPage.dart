import 'package:flutter/material.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        title: 'Donation',
        leading: ArrowBackButton(),
        child: Container(
          child: Column(
            children: [
              Center(child: Text("Donation page coming soon.")),
            ],
          ),
        ));
  }
}
