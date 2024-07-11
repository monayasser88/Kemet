import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/verification_forget_cubit.dart';
import 'package:kemet/cubit/verification_forget_state.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/screens/Create_ForgetPassword.dart';
import 'package:kemet/screens/errorPoPUP.dart';
import 'package:kemet/widget/Button.dart';
import 'package:kemet/widget/text.dart';
import 'package:flutter/services.dart';


// ignore: must_be_immutable
class verification_Forget extends StatefulWidget {
  verification_Forget({super.key});

  @override
  State<verification_Forget> createState() => _verificationState();
}

class _verificationState extends State<verification_Forget> {

 final TextEditingController ForgetVerificationController =
      TextEditingController();

  late DioConsumer dioConsumer;
  late ForgetVerificationCubit cubit;
  @override
  void initState() {
    super.initState();
    dioConsumer = DioConsumer(dio: Dio());
    cubit = ForgetVerificationCubit(api: dioConsumer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetVerificationCubit(api: DioConsumer(dio: Dio())),
      child: BlocConsumer<ForgetVerificationCubit, ForgetVerificationstate>(
          listener: (context, state) {
            // TODO: implement listener
              if (state is ForgetVerificationSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return Create_ForgetPassword();
                  }),
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text(state.msg)),
                // );
              } else if (state is ForgetVerificationError) {
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
                          key: context
                              .read<ForgetVerificationCubit>()
                              .ForgetVerificationFormKey,
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
                                      .read<ForgetVerificationCubit>()
                                      .ForgetVerificationController,
                                      
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
                              state is ForgetVerificationLoading
                                  ? const CircularProgressIndicator()
                                  : button(
                                      text: 'Verify',
                                      ontap: () {
                                        context
                                            .read<ForgetVerificationCubit>()
                                            .Forget_Verification(dioConsumer.dio);
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
