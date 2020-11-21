import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  _PaymentState createState() => _PaymentState(this.amount, this.categoryId, this.categoryId, this.name, this.image, this.packageClass, this.subject, this.board);
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
  // var orderId;
  // var razorpayId;

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
                  imageUrl: 'http://10.0.2.2:8000/storage/' + '$image',
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
                        margin: EdgeInsets.only(left: 10),
                        color: ArgonColors.success,
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
                        color: ArgonColors.primary,
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
                        color: ArgonColors.warning,
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
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(name, style: TextStyle(
                    color: ArgonColors.header,
                    fontSize: 28,
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
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
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
                            Icons.add_shopping_cart,
                            color: ArgonColors.bgColorScreen,
                            size: 32,
                          ),
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
      'key': 'rzp_test_YbFME7OVSi2Kvx',
      'amount': amount * 100,
      'name': name,
      'image': 'https://tneos.in/app-assets/img/core-img/favicon.ico',
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

  void _handlePaymentSuccess(PaymentSuccessResponse response)  {
    // orderId = 12123;
    // razorpayId = response.paymentId;
    _subscription();
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

void _subscription() async {
  var data = {
    'name': name,
    'amount': amount,
    // 'order_id': orderId,
    // 'razorpay_id': razorpayId,
    'category_id': categoryId,
    'user_id': userId};
  var res = await Network().authData(data, '/subscription');
  var body = json.decode(res.body);
  if (body['success']) {
    print('success');
  } else {
    print('failure');
  }
}
}