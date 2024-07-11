import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/sign_in_cubit.dart';
import 'package:kemet/cubit/sign_in_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/screens/forgetPassword.dart';
import 'package:kemet/screens/homepage.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/EmailTextField.dart';
import 'package:kemet/widget/text.dart';
import 'package:shared_preferences/shared_preferences.dart';


class logEmail extends StatefulWidget {
  const logEmail({super.key});

  @override
  State<logEmail> createState() => _logEmailState();
}

class _logEmailState extends State<logEmail> {
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  late DioConsumer dioConsumer;
  late SignInCubit cubit;
  @override
  void initState() {
    super.initState();
    dioConsumer = DioConsumer(dio: Dio());
    cubit = SignInCubit(api: dioConsumer);
        _checkLoginStatus();

  }
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> _saveLoginState(bool isLoggedIn, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('token', token);
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<SignInCubit, SignInstate>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SignInSuccess) {
        _saveLoginState(true, state.token);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return HomePage();
              }),
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.msg)),
            // );
          } 
          else if (state is SignInError) {
            showCustomPopupError(context);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.error)),
            // );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
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
                  key: context.read<SignInCubit>().SignInFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 140),
                      SLtext(
                        text: 'Welcome',
                        size: 32,
                        weight: FontWeight.w700,
                      ),
                      SizedBox(height: 4),
                      SLtext(
                        text: "Sign in to continue",
                        color: Color(0xff92929D),
                        size: 16,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 354,
                        height: 44,
                        child: TextFormField(
                          controller:
                              context.read<SignInCubit>().EmailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Your Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xffB68B25),
                            ),
                            floatingLabelStyle:
                                TextStyle(color: Color(0xffB68B25)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Color(0xffB68B25)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: 354,
                        height: 44,
                        child: TextField(
                          controller:
                              context.read<SignInCubit>().PasswordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                            floatingLabelStyle:
                                TextStyle(color: Color(0xffB68B25)),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xffB68B25),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xffB68B25),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xff252836)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xffB68B25)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ForgetPassword();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 240),
                          child: SLtext(
                            text: "Forgot password?",
                            color: Color(0xffB68B25),
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 250),
                      state is SignInLoading
                          ? const CircularProgressIndicator()
                          : button(
                              text: 'Send',
                              ontap: () {
                                context
                                    .read<SignInCubit>()
                                    .Sign_In(dioConsumer.dio);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
