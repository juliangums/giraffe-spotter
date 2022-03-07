import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/edit_profile/PasswordCubit.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class PasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (_)=> PasswordCubit(false),
     child: BlocBuilder<PasswordCubit, bool>(
        builder: (context, show){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Password',style: Styles.editProfileTopics),
              SizedBox(height: 5),
              TextFormField(
                key:Key('password'),
                keyboardType: TextInputType.visiblePassword,
                textDirection: TextDirection.ltr,
                obscureText: show,
                decoration: Decorations.passwordInputDecoration2(
                    onTap:()=> context.read<PasswordCubit>().toggleVisibility(),
                    showPassword: show
                ),
                textInputAction: TextInputAction.next,
                style: Styles.editProfileInput,
                initialValue: '*****************',
                cursorWidth: 1.0,
                cursorColor: Palette.accentColor,
                maxLines: 1,
              ),
            ],
          );
        }
      ),
    );
  }
}