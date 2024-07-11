// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kemet/cubit/home_cubit_cubit.dart';
// import 'package:kemet/cubit/home_cubit_state.dart';
// import 'package:kemet/logic/core/api/dio_consumer.dart';
// import 'package:kemet/screens/event-place.dart';

// // ignore: must_be_immutable
// class card extends StatelessWidget {
//   card({this.border, this.onTap});
//   final Border? border;
//   void Function()? onTap;

//   final DioConsumer dioConsumer = DioConsumer(dio: Dio());

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) =>
//             UserDataCubit(api: DioConsumer(dio: Dio()))..offer(dioConsumer.dio),
//         child: BlocConsumer<UserDataCubit, UserDataState>(
//             listener: (context, state) {
//           // TODO: implement listener
//         }, builder: (context, state) {
//           if (state is offerLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is offerSuccess) {
//             return Column(
//               children: [
//                 Container(
//                   height: 210,
//                   width: 354,
//                   child: GestureDetector(
//                     onTap: () {
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       EventsScreen()));},
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Material(
//                         elevation: 10,
//                         child: SizedBox(
//                           width: double.infinity,
//                           height: 190,
//                           child: Stack(children: [
//                             Container(
//                                 decoration: BoxDecoration(
//                                   border: border,
//                                 ),
//                                 child:  Padding(
//                                   padding: EdgeInsets.only(right: 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image(
//                                         //image:AssetImage(image),
//                                         image: NetworkImage('"https://kemet-gp2024.onrender.com/http://localhost:3000/a7da6f50-c5b2-40cf-898d-5e260429a7c0-202206010115121512.jpg'),
//                                         height: 155,
//                                         width: 155.5,
//                                         fit: BoxFit.fill,
//                                       ),
//                                       SizedBox(
//                                         width: 6,
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               right: 8, top: 10, bottom: 10),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 //title,
//                                                 state.oneId.getTitle,
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w700),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Text(
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.clip,
//                                                 softWrap: true,
//                                                 //description,
//                                                 state.oneId.getDescription,
//                                                // 'Handmade, ceramic 3" wide pinch bowls. They are also called berry bowls, somei..',
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.grey),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Text(
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.clip,
//                                                 softWrap: true,
//                                                 //description,
//                                                 'Quantity : ${state.oneId.getQuantity}',
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black),
//                                               ),
//                                               Text(
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.clip,
//                                                 softWrap: true,
//                                                 //description,
//                                                 'Price: ${state.oneId.getPrice}',
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                           ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
// Container(
//                   height: 160,
//                   width: 354,
//                   child: GestureDetector(
//                     onTap: () {
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       EventsScreen2()));},
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Material(
//                         elevation: 10,
//                         child: SizedBox(
//                           width: double.infinity,
//                           height: 190,
//                           child: Stack(children: [
//                             Container(
//                                 decoration: BoxDecoration(
//                                   border: border,
//                                 ),
//                                 child:  Padding(
//                                   padding: EdgeInsets.only(right: 5),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image(
//                                         //image:AssetImage(image),
//                                         image: NetworkImage("https://kemet-gp2024.onrender.com/http://localhost:3000/c34555de-9326-4ba6-941e-a4fa2d7385ab-Kairo_-_Altkairo_05.jpg"),
//                                         height: 250,
//                                         width: 160,
//                                         fit: BoxFit.fill,
//                                       ),
//                                       SizedBox(
//                                         width: 6,
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               right: 8, top: 10, bottom: 10),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 //title,
//                                                 state.twoId.getTitle,
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w700),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Text(
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.clip,
//                                                 softWrap: true,
//                                                 //description,
//                                                 state.twoId.getDescription,
//                                                // 'Handmade, ceramic 3" wide pinch bowls. They are also called berry bowls, somei..',
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.grey),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Text(
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.clip,
//                                                 softWrap: true,
//                                                 //description,
//                                                 'Quantity : ${state.twoId.getQuantity}',
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black),
//                                               ),
//                                               Text(
//                                                 maxLines: 3,
//                                                 overflow: TextOverflow.clip,
//                                                 softWrap: true,
//                                                 //description,
//                                                 'Price: ${state.twoId.getPrice}',
//                                                 style: TextStyle(
//                                                     fontFamily: 'poppins',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                           ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//               ],
//             );
//           } else if (state is governrateError) {
//             return Center(child: Text(state.error));
//           } else {
//             return Container(); // Placeholder for other states
//           }
//         },),);
//   }
// }
