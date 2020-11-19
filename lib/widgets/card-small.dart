import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tneos_eduloution/styles/style.dart';

class CardSmall extends StatelessWidget {
  CardSmall(
      {this.title = "Placeholder Title",
        this.cta = "",
        this.img = "https://via.placeholder.com/200",
        this.liveclass = "6",
        this.board = "CBSE",
        this.subject = "Mathematics",
        this.tap = defaultFunc});

  final String cta;
  final String img;
  final String liveclass;
  final String board;
  final String subject;
  final Function tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          height: 360,
          child: GestureDetector(
            onTap: tap,
            child: Card(
              color: ArgonColors.white,
                elevation: 0.4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 10,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: img,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(child: SpinKitCubeGrid(color: ArgonColors.inputError,)),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                        )
                    ,
                    Flexible(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff24C6DC),//brandColorPrimary,
                                    Color(0xff514A9D),//brandColorPrimary2
                                  ]
                                )
                              ),
                              padding: const EdgeInsets.only(left:8.0,right: 8.0),
                              child: Text(liveclass,
                              style: TextStyle(
                                color: ArgonColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff24C6DC),//brandColorPrimary,
                                    Color(0xff514A9D),//brandColorPrimary2
                                  ]
                                )
                              ),
                              padding: const EdgeInsets.only(left:8.0,right: 8.0),
                              child: Text(board,
                              style: TextStyle(
                                color: ArgonColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff24C6DC),//brandColorPrimary,
                                    Color(0xff514A9D),//brandColorPrimary2
                                  ]
                                )
                              ),

                              padding: const EdgeInsets.only(left:8.0,right: 8.0, top: 0, bottom: 0),
                              child: Text(subject,
                              style: TextStyle(
                                color: ArgonColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                maxLines: 2,
                                style: TextStyle(
                                    color: ArgonColors.header, fontSize: 20, fontWeight: FontWeight.w600)),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: Text(cta,
                                  style: TextStyle(
                                      color: ArgonColors.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        ))
                  ],
                )),
          ),
        ));
  }
}
