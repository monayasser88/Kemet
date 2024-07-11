import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/signup_cubit.dart';
import 'package:kemet/cubit/signup_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/screens/verification.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/text.dart';

class signEmail extends StatelessWidget {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController signUpEmailController =
      TextEditingController(); // Define the controller here

  signEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignEmailCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<SignEmailCubit, SignEmailState>(
        listener: (context, state) {
          if (state is SignEmailSuccess) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('success'),
            //   ),
            // );
            //context.read<verificationEmailCubit>().verification_Email();
            Navigator.push(context,
                MaterialPageRoute(builder: (Context) => verification()));
           
          } else if (state is SignEmailError) {
            showCustomPopupError(context);
            // Show error message
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.error)),
            // );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Sign Up',
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
                  key: context.read<SignEmailCubit>().signUpFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 195),
                      SLtext(
                        text: 'Enter your Email',
                        size: 20,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(height: 20),
                      SLtext(
                        text: "We will send a confirmation code to your Email",
                        color: Color(0xff92929D),
                        size: 14,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 354,
                        height: 44,
                        child: TextFormField(
                          controller: context
                              .read<SignEmailCubit>()
                              .signUpEmailController,
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
                      SizedBox(height: 270),
                      state is SignEmailLoading
                          ? const CircularProgressIndicator()
                          : button(
                              text: 'Send',
                              ontap: () {
                                context.read<SignEmailCubit>().signUp();
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
