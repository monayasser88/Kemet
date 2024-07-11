import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/reset_password_cubit.dart';
import 'package:kemet/cubit/reset_password_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/congratsPoPUP.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/screens/homepage.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/text.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class Create_ForgetPassword extends StatefulWidget {
  const Create_ForgetPassword({super.key});

  @override
  State<Create_ForgetPassword> createState() => _Create_PasswordState();
}

class _Create_PasswordState extends State<Create_ForgetPassword> {
  bool _isObscure = true;
  // final passNotifier = ValueNotifier<PasswordStrength?>(null);
  final TextEditingController ResetPasswordController = TextEditingController();
  late DioConsumer dioConsumer;
  late ResetPasswordCubit cubit;
  @override
  void initState() {
    super.initState();
    dioConsumer = DioConsumer(dio: Dio());
    cubit = ResetPasswordCubit(api: dioConsumer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordstate>(
        listener: (context, state) {
         
          if (state is ResetPasswordSuccess) {
            showCustomPopupCongrats(context);

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.msg)),
            // );
          } else if (state is ResetPasswordError) {
            showCustomPopupError(context);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.error)),
            // );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                   key:
                      context.read<ResetPasswordCubit>().ResetPasswordFormKey,
                  child: Column(
                    children: [
                   const SizedBox(height: 190),
                    SLtext(
                      text: 'Create a password',
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                   const SizedBox(
                      height: 20,
                    ),
                    SLtext(
                      text: 'Set a strong password to keep secure your account',
                      color: Color(0xff757171),
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                   const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 354,
                      height: 44,
                      child: TextField(
                         controller: context
                            .read<ResetPasswordCubit>()
                            .ResetPasswordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter New Password',
                          floatingLabelStyle:const TextStyle(color: Color(0xffB68B25)),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:const Color(0xffB68B25),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          prefixIcon:const Icon(
                            Icons.lock,
                            color: Color(0xffB68B25),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:const BorderSide(color: Color(0xff252836)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:const BorderSide(color: Color(0xffB68B25)),
                          ),
                        ),
                      ),
                    ),
                   const SizedBox(
                      height: 20,
                    ),
                    
                  const  SizedBox(
                      height: 40,
                    ),
                  const  SizedBox(
                      height: 140,
                    ),
                    state is ResetPasswordLoading
                        ? const CircularProgressIndicator()
                        : button(
                            text: 'Submit',
                            ontap: () {
                              context
                                  .read<ResetPasswordCubit>()
                                  .Reset_Password(dioConsumer.dio);
                            },
                          ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
