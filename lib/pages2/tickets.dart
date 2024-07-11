import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/custom_appbar.dart';
import 'package:kemet/cubit2/tickets_cubit.dart';
import 'package:kemet/pages2/account.dart';
import 'package:kemet/views2/tickets_view.dart';

class Tickets extends StatelessWidget {
  const Tickets({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        const SizedBox(height: 55),
        CustomAppBar(
          title: 'Tickets',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Account();
            }));
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocProvider(
            create: (context) => TicketsCubit()..getReservedTickets(Dio()),
            child: const TicketsView(),
          ),
        ),
      ]),
    ));
  }
}
