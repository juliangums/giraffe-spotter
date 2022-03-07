import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/capture/CaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/date_time/DateTimeCubit.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationCubit.dart';
import 'package:giraffe_spotter/models/ImageFile.dart';
import 'package:giraffe_spotter/pages/capture/widgets/ImageContainerWidget.dart';

class GridViewImages extends StatelessWidget {
  final bool pageView;

  GridViewImages({required this.pageView});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCaptureCubit, ImageFile>(
      builder: (context, state) {
        return GridView.builder(
            itemCount: _itemCount(state),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              childAspectRatio: 0.65,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext _, int index) {
              if (state.files == null || state.files!.isEmpty) {
                context.read<DateAndTimeCubit>().setTimeOfDay(null);
                context.read<DateAndTimeCubit>().setDateTime(null);
                context.read<LocationCubit>().initialState();
                context.read<CaptureCubit>().locationChanged('', 0.0, 0.0);
                context.read<ImageCaptureCubit>().longitude = null;
                context.read<ImageCaptureCubit>().latitude = null;
              }
              return state.files == null || state.files!.isEmpty
                  ? ImageContainerWidget(index: index, nothing: true)
                  : state.files!.length > index
                      ? ImageContainerWidget(index: index)
                      : ImageContainerWidget(index: index, nothing: true);
            });
      },
    );
  }

  int _itemCount(ImageFile state) {
    return (state.files == null || state.files!.length < 1)
        ? 1
        : state.files!.length == 8
            ? 8
            : state.files!.length + 1;
  }
}
