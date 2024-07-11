import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/verification_cubit.dart';
import 'package:kemet/cubit/verification_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/createPassword.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/text.dart';
import 'package:flutter/services.dart';


class verification extends StatefulWidget {
  verification({Key? key}) : super(key: key);

  @override
  State<verification> createState() => _verificationState();
}

class _verificationState extends State<verification> {
  final TextEditingController verificationEmailController =
      TextEditingController();

  late DioConsumer dioConsumer;
  late verificationEmailCubit cubit;
  @override
  void initState() {
    super.initState();
    dioConsumer = DioConsumer(dio: Dio());
    cubit = verificationEmailCubit(api: dioConsumer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => verificationEmailCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<verificationEmailCubit, verificationEmailstate>(
        listener: (context, state) {
          if (state is verificationEmailSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return Create_Password();
              }),
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.msg)),
            // );
          } else if (state is verificationEmaillError) {
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
                'Verification',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: context
                      .read<verificationEmailCubit>()
                      .verificationEmailFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 195),
                      SLtext(
                        text: 'Enter verification code',
                        size: 20,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(height: 20),
                      SLtext(
                        text: "We’ve sent a code to xxxxx@example.com",
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
                              .read<verificationEmailCubit>()
                              .verificationEmailController,
                               
                          decoration: InputDecoration(
                            labelText: 'Pin Code',
                            hintText: 'Enter Your Pin Code',
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
                      state is verificationEmailLoading
                          ? const CircularProgressIndicator()
                          : button(
                              text: 'Verify',
                              ontap: () {
                                context
                                    .read<verificationEmailCubit>()
                                    .verification_Email(dioConsumer.dio);
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
