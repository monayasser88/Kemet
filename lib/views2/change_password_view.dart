import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/custom_appbar2.dart';
import 'package:kemet/components2/custom_input_field.dart';
import 'package:kemet/constraints2%20(1).dart';
import 'package:kemet/cubit2/change_password_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password changed successfully'),
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is ChangePasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect current password'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  CustomAppBar2(
                    title: 'Change Password',
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  CustomInputField(
                    labelText: 'Current password',
                    hintText: 'Enter current password',
                    controller:
                        ChangePasswordCubit.get(context).oldPasswordController,
                    suffixIcon: true,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                    labelText: 'New password',
                    hintText: 'Enter New password',
                    controller:
                        ChangePasswordCubit.get(context).newPasswordController,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputField(
                    labelText: 'Confirm New password',
                    hintText: 'Enter Confirm New password',
                    controller: ChangePasswordCubit.get(context)
                        .confirmNewPasswordController,
                    obscureText: true,
                    suffixIcon: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  state is ChangePasswordLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(354, 44)),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(kPrimaryColor),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                }
                                return Colors.white;
                              },
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (ChangePasswordCubit.get(context)
                                      .newPasswordController
                                      .text !=
                                  ChangePasswordCubit.get(context)
                                      .confirmNewPasswordController
                                      .text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'New password and Confirm New Password do not match!',
                                    ),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                ChangePasswordCubit.get(context)
                                    .changeUserPassword(Dio());
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('New passwords do not match'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
