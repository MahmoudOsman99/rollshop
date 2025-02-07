import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/components/widgets/custom_text_field.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    super.key,
    required this.passwordController,
    this.validator,
    this.hintText,
  });

  final TextEditingController passwordController;
  final String? Function(String? value)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFieldController: passwordController,
      isPassword: !context.read<AuthCubit>().showPassword,
      validator: validator,
      sufixIcon: GestureDetector(
        onTap: () {
          context.read<AuthCubit>().changeShowPassword();
        },
        child: Icon(
          context.read<AuthCubit>().showPassword
              ? Icons.visibility_off
              : Icons.visibility,
        ),
      ),
      inputAction: TextInputAction.done,
      hintText: hintText,
    );
  }
}
