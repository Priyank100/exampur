import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

import '../presentation/home/books/books_ebooks.dart';
import '../utils/analytics_constants.dart';

class PlaceOrderScreen extends StatefulWidget {
  final BookEbook books;

  const PlaceOrderScreen(this.books) : super();

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  // void initState() {
  //   Future.delayed(Duration.zero, () {
  //     AppConstants.routeName = ModalRoute.of(context)!.settings.name!;
  //   });}
  // Future<bool> _onWillPop(BuildContext context) async {
  //   if(AppConstants.routeName == 'Direct'){
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //         builder: (context) => BooksEbook()
  //     ));
  //   } else{
  //     Navigator.pop(context);
  //   }
  //   return Future.value(true);
  // }
  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: () => _onWillPop(context),
      // child:
      Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3,
              // child: CachedNetworkImage(
              //   imageUrl:
              //       widget.books.bannerPath.toString(),
              //   errorWidget: (context, url, error) => new Icon(Icons.error),
              // ),
              child: widget.books.bannerPath.toString().contains('http') ?
              AppConstants.image(widget.books.bannerPath.toString()) :
              AppConstants.image(AppConstants.BANNER_BASE + widget.books.bannerPath.toString()),

            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.books.title.toString(),
                softWrap: true,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.books.description.toString(),
                softWrap: true,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                getTranslated(context,LangString.priceBreakdown)!,
                softWrap: true,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context,LangString.Price)!,
                    softWrap: true,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '₹ ${widget.books.regularPrice.toString()}',
                    softWrap: true,
                    style: TextStyle(fontSize: 14,decoration: TextDecoration.lineThrough,color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context,LangString.sellingPrice)!,
                    softWrap: true,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '₹ ${widget.books.salePrice.toString()}',
                    softWrap: true,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Divider(thickness: 1,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, LangString.TotalAmount)!,
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '₹ ${widget.books.salePrice.toString()}',
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(thickness: 1,),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: CustomElevatedButton(
                  onPressed: () {
                    var map = {
                      'Page_Name':'Confirm_Book_Purchase',
                      'Mobile_Number':AppConstants.userMobile,
                      'Language':AppConstants.langCode,
                      'User_ID':AppConstants.userMobile,
                      'Book_Name':widget.books.title.toString()
                    };
                    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Place_Order,map);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          DeliveryDetailScreen('Book', widget.books.id.toString(),
                              widget.books.title.toString(), widget.books.salePrice.toString()
                          )
                      ),
                    );
                  },
                  text:getTranslated(context, LangString.placeOrder)!,
                ),
              ),
            ),
          ],
          // ),
        ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         width: double.maxFinite,
        //         height: MediaQuery.of(context).size.height / 3,
        //         // child: CachedNetworkImage(
        //         //   imageUrl:
        //         //       widget.books.bannerPath.toString(),
        //         //   errorWidget: (context, url, error) => new Icon(Icons.error),
        //         // ),
        //         child: AppConstants.image(AppConstants.BANNER_BASE +widget.books.bannerPath.toString(),boxfit: BoxFit.fill),
        //
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Text(
        //           widget.books.title.toString(),
        //           softWrap: true,
        //           style: TextStyle(fontSize: 20),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Text(
        //           widget.books.description.toString(),
        //           softWrap: true,
        //           style: TextStyle(fontSize: 15),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Text(
        //           getTranslated(context,LangString.priceBreakdown)!,
        //           softWrap: true,
        //           style: TextStyle(fontSize: 16),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               getTranslated(context,LangString.Price)!,
        //               softWrap: true,
        //               style: TextStyle(fontSize: 14),
        //             ),
        //             Text(
        //               '₹ ${widget.books.regularPrice.toString()}',
        //               softWrap: true,
        //               style: TextStyle(fontSize: 14,decoration: TextDecoration.lineThrough,color: AppColors.grey),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               getTranslated(context,LangString.sellingPrice)!,
        //               softWrap: true,
        //               style: TextStyle(fontSize: 14),
        //             ),
        //             Text(
        //               '₹ ${widget.books.salePrice.toString()}',
        //               softWrap: true,
        //               style: TextStyle(fontSize: 14),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Divider(thickness: 1,),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               getTranslated(context, LangString.TotalAmount)!,
        //               softWrap: true,
        //               style: TextStyle(fontSize: 16),
        //             ),
        //             Text(
        //               '₹ ${widget.books.salePrice.toString()}',
        //               softWrap: true,
        //               style: TextStyle(fontSize: 16),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Divider(thickness: 1,),
        //       ),
        //       SizedBox(height: 16,),
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 10),
        //         child: Align(
        //           alignment: FractionalOffset.bottomCenter,
        //           child: CustomElevatedButton(
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (context) =>
        //                     DeliveryDetailScreen('Book', widget.books.id.toString(),
        //                         widget.books.title.toString(), widget.books.salePrice.toString()
        //                     )
        //                 ),
        //               );
        //             },
        //             text:getTranslated(context, LangString.placeOrder)!,
        //           ),
        //         ),
        //       ),
        //     ],
        //     // ),
        //   ),
        // ),
        // bottomNavigationBar:  Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: Align(
        //     alignment: FractionalOffset.bottomCenter,
        //     child: CustomElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) =>
        //               DeliveryDetailScreen('Book', widget.books.id.toString(),
        //                   widget.books.title.toString(), widget.books.salePrice.toString()
        //               )
        //           ),
        //         );
        //       },
        //       text:getTranslated(context, LangString.placeOrder)!,
        //     ),
        //   ),
        // ),
   //   ),
    );
  }
}
