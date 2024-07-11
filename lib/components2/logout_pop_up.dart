import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/constraints2%20(1).dart';
import 'package:kemet/cubit2/logout_cubit.dart';
import 'package:kemet/pages2/setting.dart';
import 'package:kemet/screens/login.dart';


class LogOutPopUp extends StatelessWidget {
  const LogOutPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          // TODO: implement listener
            if (state is LoggedOutSuccess) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  login()),
                                (route) => false);
                          }
          if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMassage),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Image(
                      image: AssetImage('images/congratsImage.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Are you sure',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        //color: Colors.black
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'You are attending to log out , Are you sure?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      style:  ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xffB68B25)),
                        minimumSize: MaterialStatePropertyAll(Size(340, 50)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        )),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.white;
                        },
                      ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                        onTap: () {
                          //logoutCubit.logout();
                          LogoutCubit.get(context).logout2(Dio());
                        },
                        child: state is LogoutLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Log Out',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'poppins',
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              )),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void showCustomPopup(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LogOutPopUp();
    },
  );
}
