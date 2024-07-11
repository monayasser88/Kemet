import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/custom_container_in_profile.dart';
import 'package:kemet/components2/custom_title_in_profile.dart';
import 'package:kemet/components2/custom_title_in_profile2.dart';
import 'package:kemet/components2/logout_pop_up.dart';
import 'package:kemet/components2/update_pop_up.dart';
import 'package:kemet/constraints2%20(1).dart';
import 'package:kemet/cubit2/profile_cubit.dart';
import 'package:kemet/models2/user_model.dart';
import 'package:kemet/pages2/change_password.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  //late Dio dio;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LogOutPopUp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Add any necessary listener logic here
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          firstNameController.text = state.profile.firstName ?? '';
          lastNameController.text = state.profile.lastName ?? '';
          cityController.text = state.profile.city ?? '';
          emailController.text = state.profile.email ?? '';
          return ProfileUser(state.profile, context);
        } else {
          return const Center(
            child: Text('Error loading profile'),
          );
        }
        //return CircularProgressIndicator();
      },
    );
  }

  Widget ProfileUser(Profile profile, BuildContext context) =>
      SingleChildScrollView(
        child: SizedBox(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTitle(
                titleProfile: 'First name',
                onTap: () => showUpdateDialog(
                  context,
                  'Update First Name',
                  'Enter First Name',
                  firstNameController,
                  () async {
                    ProfileCubit.get(context).updateFirstName(
                        firstNameController.text, Dio(), firstNameController);
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.of(context).pop();
                  },
                ),
                userInfo: firstNameController.text,
              ),
              const SizedBox(height: 10),
              CustomTitle(
                titleProfile: 'Last name',
                onTap: () => showUpdateDialog(
                  context,
                  'Update Last Name',
                  'Enter Last Name',
                  lastNameController,
                  () async {
                    ProfileCubit.get(context).updateLastName(
                        lastNameController.text, Dio(), lastNameController);
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.of(context).pop();
                  },
                ),
                userInfo: lastNameController.text,
              ),
              const SizedBox(height: 10),
              CustomTitleEmail(
                titleProfile: 'Email',
                userInfo: emailController.text,
              ),
              const SizedBox(height: 10),
              CustomTitle(
                titleProfile: 'City',
                onTap: () => showUpdateDialog(
                  context,
                  'Update City',
                  'Enter City',
                  cityController,
                  () async {
                    ProfileCubit.get(context)
                        .updateCity(cityController.text, Dio(), cityController);
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.of(context).pop();
                  },
                ),
                userInfo: cityController.text,
              ),
              const SizedBox(height: 10),
              const Flexible(
                child: Divider(
                  thickness: 1,
                  color: Color(0xff92929D),
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              const SizedBox(height: 10),
              ContainerProfile(
                forwardName: 'Change Password',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ChangePassword(),
                    ),
                  );
                },
              ),
              ContainerProfile(
                forwardName: 'Log out',
                color: kPrimaryColor,
                onTap: () => showCustomPopup(context),
              ),
            ],
          ),
        ),
      );
}
