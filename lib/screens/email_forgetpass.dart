import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/email_forget_cubit.dart';
import 'package:kemet/cubit/email_forget_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/screens/verification_forget.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/EmailTextField.dart';
import 'package:kemet/widget/text.dart';

class Email_ForgetPass extends StatelessWidget {
  Email_ForgetPass({Key? key}) : super(key: key);
  final TextEditingController EmailForgetController = TextEditingController();

    final DioConsumer dioConsumer = DioConsumer(dio: Dio());

  late EmailForgetCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>EmailForgetCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<EmailForgetCubit, EmailForgetstate>(
        listener: (context, state) {
      

          if (state is EmailForgetSuccess) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('success'),
            //   ),
            // );
            //context.read<verificationEmailCubit>().verification_Email();
            Navigator.push(context,
                MaterialPageRoute(builder: (Context) => verification_Forget()));
          } else if (state is EmailForgetError) {
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
          key: context.read<EmailForgetCubit>().EmailForgetFormKey,

                  child: Column(
                    children: [
                    const  SizedBox(height: 195),
                      SLtext(
                        text: 'Enter your Email',
                        size: 20,
                        weight: FontWeight.w600,
                      ),
                     const SizedBox(height: 20),
                      SLtext(
                        text: "We will send a confirmation code to your Email",
                        color:const Color(0xff92929D),
                        size: 14,
                        weight: FontWeight.w500,
                      ),
                    const  SizedBox(height: 20),
                      Container(
                        width: 354,
                        height: 44,
                        child: TextFormField(
                          controller: context
                              .read<EmailForgetCubit>()
                              .EmailForgetController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter Your Email',
                            prefixIcon:const Icon(
                              Icons.email,
                              color: Color(0xffB68B25),
                            ),
                            floatingLabelStyle:
                             const  TextStyle(color: Color(0xffB68B25)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:const BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:const BorderSide(color: Color(0xffB68B25)),
                            ),
                          ),
                        
                        ),
                      ),
                    const  SizedBox(height: 270),
                       state is EmailForgetLoading
                          ? const CircularProgressIndicator()
                          : button(
                              text: 'Send',
                              ontap: () {
                                context.read<EmailForgetCubit>().Email_Forget(dioConsumer.dio);
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
