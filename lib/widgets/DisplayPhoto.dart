import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationBloc.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationEvent.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/utils/GalleryUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/models/ImageFile.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';

import 'SpinKitFadingCircle.dart';

class DisplayPhoto extends StatelessWidget {

  final bool drawerClose;

  DisplayPhoto({ required this.drawerClose});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ImageCaptureCubit>(context),
      child: Stack(
        children: [
          BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
              listener: listening,
              builder: (context, _) {
                return BlocConsumer<ImageCaptureCubit, ImageFile>(
                        listener: listeningPhoto,
                        builder: (context, state) {
                          return CircleAvatar(
                              radius: 40,
                              child: Container(padding: EdgeInsets.fromLTRB(15,14,0,0), child: _.status.isSubmissionInProgress && _.image == true ? SpinKitFadingCircle(color: Palette.primaryColor, size: 25) : SizedBox()),
                              backgroundImage: (_.status.isSubmissionInProgress  && _.image == true ) || _.status.isSubmissionFailure ? null :
                              (_.status.isSubmissionSuccess || context.read<AuthenticationBloc>().state.user.profile_image != null) ?
                              CachedNetworkImageProvider(context.read<AuthenticationBloc>().state.user.profile_image.toString()) : null
                       );
                   },
                 );
              },
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: ()=> GalleryUtils().pickImage(context),
              child: Transform(
                transform: Matrix4.translationValues(0, 17, 0),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Palette.orangeColor,
                      child: SvgPicture.asset(Assets.camera,height: 25,width: 20)
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void listeningPhoto(BuildContext context, ImageFile state) {
    if(state.status == FormzStatus.submissionSuccess) {
      context.read<UpdateProfileCubit>().updateImage(state.file!);
    }
  }

  void listening(BuildContext context, UpdateProfileState state) {
    if(state.status ==  FormzStatus.submissionFailure) {
      if(drawerClose == true) {
        locator!<AppRoute>().back();
      }
      if(state.errors != null)
      GradientSnackBar.showErrorMessage(context, (state.errors!['image'] as List).first);
    }
    if(state.status == FormzStatus.submissionSuccess) {
      context.read<AuthenticationBloc>().add(AuthenticationUserChanged(state.user));
    }
  }
}
