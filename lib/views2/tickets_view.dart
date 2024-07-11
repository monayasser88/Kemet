import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/ticket_container.dart';
import 'package:kemet/components2/total_container.dart';
import 'package:kemet/cubit2/tickets_cubit.dart';
import 'package:kemet/models2/tickets.dart';

class TicketsView extends StatelessWidget {
  const TicketsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketsCubit, TicketsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! TicketsLoading,
          builder: (BuildContext context) {
            if (state is TicketsSuccess ||
                state is TicketDeleteSuccess ||
                state is ShippingSuccess) {
              final total = TicketsCubit.get(context).myTicket!;
              return ticketsPage(total, context);
            } else if (state is NoTicketsFound) {
              return const Center(
                  child: Text(
                'No tickets found.',
                style: TextStyle(fontFamily: 'poppins', fontSize: 20),
              ));
            } else if (state is TicketsError) {
              return Container(
                child: Text(state.errMassage),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget ticketsPage(MyTicket total, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: total.myTicketItems.length,
              itemBuilder: (context, index) {
                MyTicketItem item = total.myTicketItems![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TicketContainer(
                    title: item.trip.title.toString(),
                    description: item.trip.description.toString(),
                    quantity: item.quantity.toString(),
                    price: item.price.toString(),
                    onPressed: () {
                      TicketsCubit.get(context).deleteTicket(Dio(), item.myTId);
                    },
                    quantityMinus: () {
                      TicketsCubit.get(context)
                          .quantityTicket(Dio(), item.myTId, item.quantity - 1);
                    },
                    quantityPlus: () {
                      TicketsCubit.get(context)
                          .quantityTicket(Dio(), item.myTId, item.quantity + 1);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          if (total.myTicketItems.isEmpty)
            const SizedBox(height: 10)
          else
            const SizedBox(height: 10),
          if (total.myTicketItems.isNotEmpty)
            TotalContainer(total: total.totalPrice.toString()),
          const SizedBox(height: 10),
        ],
      );
}
