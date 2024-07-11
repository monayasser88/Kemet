import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/components2/custom_appbar.dart';
import 'package:kemet/components2/custom_field.dart';
import 'package:kemet/components2/delivary_pop_up.dart';
import 'package:kemet/components2/pay_field.dart';
import 'package:kemet/components2/phonefield.dart';
import 'package:kemet/cubit2/tickets_cubit.dart';
import 'package:kemet/pages2/tickets.dart';

class Order extends StatelessWidget {
  Order({super.key});
  GlobalKey<FormState> orderFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketsCubit(),
      child: BlocConsumer<TicketsCubit, TicketsState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ShippingSuccess) {
            showCustomPopupdelivary(context);
          } else if (state is PayingLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Prepare your credit card to enter you card information!'),
                duration: Duration(seconds: 3),
              ),
            );
          } else if (state is ShippingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMassage),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Form(
              key: orderFormKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(children: [
                    const SizedBox(
                      height: 55,
                    ),
                    CustomAppBar(
                      title: 'Order',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Tickets();
                        }));
                      },
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    CustomField(
                      controller: TicketsCubit.get(context).streetField,
                      label: 'Street',
                      hint: 'Enter your street!',
                      suffixIcon: Icon(size: 24, Icons.home_work),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomField(
                      controller: TicketsCubit.get(context).cityField,
                      label: 'City',
                      hint: 'Enter your city!',
                      suffixIcon: Icon(size: 24, Icons.location_city),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PhoneField(
                      controller: TicketsCubit.get(context).phoneField,
                      label: 'Phone',
                      hint: 'Enter your phone!',
                      suffixIcon: Icon(size: 24, Icons.phone),
                    ),
                    const SizedBox(
                      height: 400,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PayField(
                          text: 'Pay Online',
                          ontap: () {
                            if (orderFormKey.currentState!.validate()) {
                              orderFormKey.currentState!.save();
                            }
                            TicketsCubit.get(context)
                                .createOnlineOrder(Dio(), context);
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        state is ShippingLoading
                            ? const CircularProgressIndicator()
                            : PayField(
                                text: 'Pay Cash',
                                ontap: () {
                                  if (orderFormKey.currentState!.validate()) {
                                    orderFormKey.currentState!.save();
                                  }
                                  TicketsCubit.get(context).createOrder(Dio());
                                },
                              ),
                      ],
                    )
                  ])),
            ),
          ));
        },
      ),
    );
  }
}