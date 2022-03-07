import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/blocs/share_button/ShareButtonCubit.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:share/share.dart';

class ShareButton extends StatelessWidget {
  const ShareButton(
      {Key? key, this.id = '', this.shareit = false, this.shareLink})
      : super(key: key);
  final String? shareLink;
  final String? id;
  final bool? shareit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShareButtonCubit(),
      child: BlocBuilder<ShareButtonCubit, bool>(
        buildWhen: (previous, current) => current != previous,
        builder: (context, state) {
          return BlocListener<DynamicCubit, DynamicState>(
            listener: _listener,
            child: IconButton(
                onPressed: () async {
                  if (state) return;
                  if (shareLink.toString() == '') return;
                  if (shareit == true) {
                    context.read<DynamicCubit>().createDynamicLink(id!, false);
                  }else{
                    context.read<ShareButtonCubit>().getLink(true);
                    final RenderBox? box =
                    context.findRenderObject() as RenderBox;
                    Share.share(
                        shareLink.toString(),
                        sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
                    context.read<ShareButtonCubit>().getLink(false);
                  }
                },
                icon: SvgPicture.asset(Assets.shareIcon)),
          );
        },
      ),
    );
  }

  void _listener(BuildContext context, DynamicState state) {
    if(state.status ==  FormzStatus.submissionSuccess) {
      context.read<ShareButtonCubit>().getLink(true);
      final RenderBox? box = context.findRenderObject() as RenderBox;
      Share.share(state.shorturl.toString(), sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      context.read<ShareButtonCubit>().getLink(false);
    }
  }
}
