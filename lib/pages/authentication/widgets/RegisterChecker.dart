// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:giraffe_spotter/blocs/sign_up/SignUpCubit.dart';
// import 'package:giraffe_spotter/blocs/sign_up/SignUpState.dart';
// import 'package:giraffe_spotter/config/Palette.dart';
// import 'package:giraffe_spotter/config/Styles.dart';
//
// class RegisterChecker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Transform.translate(
//           offset: Offset(11, -1),
//           child: Transform.scale(
//             scale: 0.85,
//             child: BlocBuilder<SignUpCubit, SignUpState>(
//               buildWhen: (previous, current) => previous.acceptTerms != current.acceptTerms,
//               builder: (context, state) => Checkbox(
//                 checkColor: Palette.primaryColor,
//                 activeColor: Palette.tertiaryColor,
//                 value: state.acceptTerms.value,
//                 onChanged: (change) {
//                   context.read<SignUpCubit>().acceptTermsChanged(change);
//                 },
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 5),
//         Padding(
//           padding: const EdgeInsets.only(top: 12.6),
//           child: Text("By creating an account you agree with our terms\nand conditions",
//               style: Styles.labelTextFormField.copyWith(height: 1.21)),
//         )
//       ],
//     );
//   }
// }
