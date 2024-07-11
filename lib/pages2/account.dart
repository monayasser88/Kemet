import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kemet/components2/custom_appbar.dart';
import 'package:kemet/components2/custom_container_in_account.dart';
import 'package:kemet/components2/logout_pop_up.dart';
import 'package:kemet/components2/photo_account.dart';
import 'package:kemet/pages2/change_password.dart';
import 'package:kemet/pages2/favorite_kinds.dart';
import 'package:kemet/pages2/setting.dart';
import 'package:kemet/pages2/tickets.dart';
import 'package:kemet/screens/homepage.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            const SizedBox(
              height: 55,
            ),
            CustomAppBar(
              title: 'Account',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
            },
            ),
            const SizedBox(
              height: 29,
            ),
            const PhotoAccount(),
            const SizedBox(
              height: 27,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: 'account',
                );
              },
              child: const ContainerAccount(
                  contName: 'Profile', contIcon: Icons.person_outline_rounded),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ChangePassword();
                }));
              },
              child: const ContainerAccount(
                  contName: 'Change Password',
                  contIcon: CupertinoIcons.lock_rotation_open),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Tickets();
                }));
              },
              child: const ContainerAccount(
                  contName: 'My Tickets', contIcon: CupertinoIcons.tickets),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const FavoriteKinds();
                  //SearchPage();
                }));
              },
              child: const ContainerAccount(
                  contName: 'Favorites', contIcon: CupertinoIcons.heart),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Setting();
                }));
              },
              child: const ContainerAccount(
                  contName: 'Setting', contIcon: Icons.settings_outlined),
            ),
            const SizedBox(
              height: 15,
            ),
            ContainerAccount(
              contName: 'Log Out',
              contIcon: Icons.logout,
              onTap: () {
                showCustomPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
