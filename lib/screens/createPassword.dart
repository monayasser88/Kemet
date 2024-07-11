import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/create_password_cubit.dart';
import 'package:kemet/cubit/create_password_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/createProfile.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/text.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class Create_Password extends StatefulWidget {
  const Create_Password({super.key});

  @override
  State<Create_Password> createState() => _Create_PasswordState();
}

class _Create_PasswordState extends State<Create_Password> {
  bool _isObscure = true;
  bool _isObscureConfirm = true;
 // final passNotifier = ValueNotifier<PasswordStrength?>(null);
  final TextEditingController createpasswordController =
      TextEditingController();
  final TextEditingController createrepasswordController =
      TextEditingController();

  late DioConsumer dioConsumer;
  late createpasswordCubit cubit;
  @override
  void initState() {
    super.initState();
    dioConsumer = DioConsumer(dio: Dio());
    cubit = createpasswordCubit(api: dioConsumer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createpasswordCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<createpasswordCubit, createpasswordstate>(
        listener: (context, state) {
       
          if (state is createpasswordSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return const CreateProfilePage();
              }),
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.msg)),
            // );
          } else if (state is createpasswordError) {
            showCustomPopupError(context);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.error)),
            // );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title:const Text(
                'Create Password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  //color: Colors.black,
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
                      context.read<createpasswordCubit>().createpasswordFormKey,
                  child: Column(children: [
                   const SizedBox(height: 190),
                    SLtext(
                      text: 'Create a password',
                      //color: Color(0xff000000),
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                  const  SizedBox(
                      height: 20,
                    ),
                    SLtext(
                      text: 'Set a strong password to keep secure your account',
                      color: Color(0xff757171),
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  const  SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 354,
                      height: 44,
                      child: TextField(
                        controller: context
                            .read<createpasswordCubit>()
                            .createpasswordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter New Password',
                          floatingLabelStyle:
                             const TextStyle(color: Color(0xffB68B25)),
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
                  const  SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 354,
                      height: 44,
                      child: TextField(
                        controller: context
                            .read<createpasswordCubit>()
                            .createrepasswordController,
                        obscureText: _isObscureConfirm,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter Confirm Password',
                          floatingLabelStyle:
                            const  TextStyle(color: Color(0xffB68B25)),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isObscureConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:const Color(0xffB68B25),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscureConfirm = !_isObscureConfirm;
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
                   const SizedBox(height: 20),
                  
                   const SizedBox(
                      height: 40,
                    ),

                   const SizedBox(
                      height: 140,
                    ),
                    state is createpasswordLoading
                        ? const CircularProgressIndicator()
                        : button(
                            text: 'Submit',
                            ontap: () {
                              context
                                  .read<createpasswordCubit>()
                                  .createpassword(dioConsumer.dio);
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
