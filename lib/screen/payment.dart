import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';
import 'package:flutter/services.dart';

class Payment extends StatefulWidget {
  final int amount;
  final int categoryId;
  final int userId;
  final String name;
  final String image;
  final int packageClass;
  final String subject;
  final String board;
  Payment(this.amount, this.categoryId, this.userId, this.name, this.image, this.packageClass, this.subject, this.board);
  @override
  _PaymentState createState() => _PaymentState(this.amount, this.categoryId, this.userId, this.name, this.image, this.packageClass, this.subject, this.board);
}

class _PaymentState extends State<Payment> {
  static const platform = const MethodChannel("razorpay_flutter");
  int amount;
  int categoryId;
  int userId;
  String name;
  String image;
  int packageClass;
  String subject;
  String board;

  Razorpay _razorpay;
   var orderId;
   var razorpayId;

  _PaymentState(this.amount, this.categoryId, this.userId, this.name,
      this.image, this.packageClass, this.subject, this.board);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ArgonColors.bgColorScreen,
        appBar: Navbar(
          title: "Buy Now",
        ),
        drawer: ArgonDrawer(
          currentPage: "Buy Now",
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: CachedNetworkImage(
                  imageUrl: 'https://tneos.in/storage/' + '$image',
                  placeholder: (context, url) =>
                      Center(child: SpinKitCubeGrid(
                        color: ArgonColors.inputError,)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ArgonColors.success,
                        ),
                        margin: EdgeInsets.only(left: 10),

                        child: Text(board,
                            style: TextStyle(
                              color: ArgonColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        padding: const EdgeInsets.all(4.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ArgonColors.primary,
                        ),
                        child: Text(subject,
                            style: TextStyle(
                              color: ArgonColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        padding: const EdgeInsets.all(4.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ArgonColors.warning,
                        ),
                        child: Text("${packageClass}th class",
                            style: TextStyle(
                              color: ArgonColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        padding: const EdgeInsets.all(4.0),
                      ),

                    ],
                  ),

                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(name, style: TextStyle(
                    color: ArgonColors.header,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      "This course is $name, In this course, you will introduce to class ${packageClass}th $subject of $board. The course include all the lecture and live classes from our subject expert."
                      ,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Note: Please Check if you have already purchased the course in your profile page before buying.',
                      style: TextStyle(
                        fontSize: 8,
                        color: ArgonColors.error,
                      )
                    ),
                  ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: ArgonColors.success,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.shoppingCart,
                            color: ArgonColors.bgColorScreen,
                            size: 32,
                          ),
                          SizedBox(width: 20,),
                          Text('BUY NOW', style: TextStyle(
                            color: ArgonColors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,

                          ))
                        ],
                      ),
                      onPressed: () {
                        openCheckout();
                      }),
                ),
              )
            ],
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }


  void openCheckout() async {
    var options = {
      'key': 'rzp_live_CsYsxq7OyyehDC',
      'amount': amount * 100,
      'name': name,
      'image': 'https://i.imgur.com/YfB6RPZ.png',
      'description': 'Buy the Course to get access for all live classes',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response)  async {
     orderId = response.orderId;
     razorpayId = response.paymentId;
    var data = {
      'name': name,
      'amount': amount,
      'order_id': orderId,
      'razorpay_id': razorpayId,
      'category_id': categoryId,
      'user_id': userId};
    var res = await Network().postData(data, '/subscription');
    var body = json.decode(res.body);
    if (body['success']) {
       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Payment Done Successfully')));
    } else {
      // Fluttertoast.showToast(
      //     msg: "Kindly Contact US: " + response.paymentId, timeInSecForIosWeb: 4);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Kindly Contact US"+ response.paymentId)));
    }
    // _subscription();

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("ERROR: " + response.code.toString() + " - " + response.message)));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("EXTERNAL_WALLET: " + response.walletName)));
  }


// void _subscription() async {
//   var data = {
//     'name': name,
//     'amount': amount,
//     // 'order_id': orderId,
//     // 'razorpay_id': razorpayId,
//     'category_id': categoryId,
//     'user_id': userId};
//   var res = await Network().postData(data, '/subscription');
//   var body = json.decode(res.body);
//   if (body['success']) {
//     print('success');
//   } else {
//     print('failure');
//   }
// }
}