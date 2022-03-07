import 'package:flutter/material.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class AdoptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        title: 'Adoption',
        leading: ArrowBackButton(),
        child: Container(
          child: Column(
            children: [
              Center(child: Text("Adoption page coming soon.")),
            ],
          ),
        ));
  }
}
