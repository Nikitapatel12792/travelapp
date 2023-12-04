import 'dart:convert';

import 'package:escapingplan/Modal/invoicemodel.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/load.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);
  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  InvoiceModel? invoicemodel;
  bool isLoading =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     isLoading =true;
    invoiceap();
  }
  design(){
    return commanScreen(
        scaffold: Scaffold(
            body: isLoading ? Container():

            (invoicemodel?.data?.fullCostOfBooking == "" && invoicemodel?.data?.paymentMode == "")?
            Container(
              alignment: Alignment.center,
              child: Center(child: Text("No data available",style: textStyle2,)),
            ):
            Container(
              height: 20.h,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
              margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
                // color: Colors.grey.shade200,
                color: Colors.white,
              ),
              child:Column(
                children: [
                  Row(
                    children: [
                      Text("Full cost of booking : ",style: textStyle1,),
                      Text((invoicemodel?.data?.fullCostOfBooking == null || invoicemodel?.data?.fullCostOfBooking == "")?"No data available":invoicemodel?.data?.fullCostOfBooking ?? "" ,style: textStyle2,)
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      Text("Payment Mode : ",style: textStyle1,),
                      Text((invoicemodel?.data?.paymentMode == null || invoicemodel?.data?.paymentMode == "")?"No data available" : invoicemodel?.data?.paymentMode ?? "" ,style: textStyle2,)
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      Text("Remaining Balance : ",style: textStyle1,),
                      Text((invoicemodel?.data?.remainingBalance == null || invoicemodel?.data?.remainingBalance == "")?"No data available" : invoicemodel?.data?.remainingBalance ?? "" ,style: textStyle2,)
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      Text("Due By: ",style: textStyle1,),
                      Text((invoicemodel?.data?.dueBy == null || invoicemodel?.data?.dueBy == "")?"No data available" : invoicemodel?.data?.dueBy ?? "" ,style: textStyle2,)
                    ],
                  )
                ],
              ),
            )
        ),
        isLoading: isLoading
    );
  }
  @override
  Widget build(BuildContext context) {
    return  design();
  }
  TextStyle textStyle1 = TextStyle(
      fontFamily: "Poppins",
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600);
  TextStyle textStyle2 = TextStyle(
      fontFamily: "Poppins",
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400);
  // api call
  invoiceap() {
    final Map<String, String> data = {};
    data['id'] =userData?.data?[0].itineraryId ?? "";
    data['action'] = 'invoice_history';
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().invoiceapi(data).then((Response response) async {
          invoicemodel = InvoiceModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && invoicemodel?.status == 1) {



            print(invoicemodel?.data?.paymentMode);

            setState(() {
              isLoading = false;
            });
            if (kDebugMode) {}
          } else {
            setState(() {
              isLoading = false;
            });
            // buildErrorDialog(context, "", "Invalid login");
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}
