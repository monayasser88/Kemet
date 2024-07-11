import 'package:flutter/material.dart';
import 'package:kemet/components2/custom_text.dart';
import 'package:kemet/constraints2%20(1).dart';


class FavoriteContainer extends StatelessWidget {
  const FavoriteContainer(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      this.onPressed});
  final String title;
  final String description;
  final String image;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        elevation: 10,
        child: SizedBox(
          width: double.infinity,
          height: 140,
          child: Stack(children: [
            Container(
                decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(color: kPrimaryColor, width: 5),
                      bottom: BorderSide(color: kPrimaryColor, width: 5),
                      left: BorderSide(color: Colors.grey, width: .5),
                      top: BorderSide(color: Colors.grey, width: .5)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(image),
                        fit: BoxFit.fill,
                        height: 250,
                        width: 130,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: 8, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: title,
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              Spacer(),
                              Text(
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                description,
                                //'pyramids plllllll llalallllllll lllllalalala lllllmiuvhj huygtvbm pmpmp mpmmpmm pmpm pmpmpkj hgfds asdfg hjkjhg fdfghj',
                                style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                        Padding(
                        padding:const EdgeInsets.only(top: 30),
                        child:  IconButton(
                          icon:const Icon(Icons.clear_rounded,
                          size: 30,),
                          onPressed:onPressed
                          
                        ),
                      )
                    ],
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
