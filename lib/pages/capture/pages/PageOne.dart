import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationBloc.dart';
import 'package:giraffe_spotter/blocs/capture/CaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/date_time/DateTimeCubit.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/ImageFile.dart';
import 'package:giraffe_spotter/pages/capture/pages/PageTwo.dart';
import 'package:giraffe_spotter/pages/capture/widgets/GridViewImages.dart';
import 'package:giraffe_spotter/widgets/CustomContainer.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:url_launcher/url_launcher.dart';

class PageOne extends StatelessWidget {
  _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCaptureCubit, ImageFile>(
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Palette.primaryColor,
          body: CustomContainer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Styles.captureDetails,
                          text: 'We recommend you take a photo of both\nsides of the giraffe or at least the left side. Click \n',
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => _launchURL('https://giraffespotter.org/photographing.jsp'),
                          style: Styles.captureDetailsLink,
                          text: 'here',
                        ),
                        TextSpan(
                          style: Styles.captureDetails,
                          text: ' to learn how a good photo looks like.',
                        ),
                      ],
                    ),
                  ),
                ),
                GridViewImages(pageView: true),
                PageTwo(),
                SizedBox(height: 10),
                BlocBuilder<CaptureCubit, CaptureState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 14, right: 23),
                      child: LargeButtonReplacement(
                        title: 'Submit',
                        loading: (state.status == FormzStatus.submissionInProgress) ? true : false,
                        active: (context.read<DateAndTimeCubit>().timeOfDays != null &&
                                context.read<DateAndTimeCubit>().copyWithTime != null &&
                                state.location.isNotEmpty &&
                                context.read<ImageCaptureCubit>().assets.isNotEmpty)
                            ? true
                            : false,
                        onTap: () => (context.read<DateAndTimeCubit>().timeOfDays != null &&
                                context.read<DateAndTimeCubit>().copyWithTime != null &&
                                state.location.isNotEmpty &&
                                context.read<ImageCaptureCubit>().assets.isNotEmpty)
                            ? {
                                context.read<CaptureCubit>().captureData(
                                    context.read<AuthenticationBloc>().state.user.uuid, context.read<ImageCaptureCubit>().assets)
                              }
                            : {},
                      ),
                    );
                  },
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        );
      },
    );
  }
}
