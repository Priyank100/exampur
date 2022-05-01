import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/shared/place_order_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

class BooksCard extends StatefulWidget {
  final BookEbook  books;

  const BooksCard(this.books) : super();

  @override
  _BooksCardState createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            offset: Offset(
              0.0,
              0.0,
            ),
            blurRadius: 1.79,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        children: [
          widget.books.bannerPath.toString().contains('http') ?
          AppConstants.image(widget.books.bannerPath.toString()) :
          AppConstants.image(AppConstants.BANNER_BASE + widget.books.bannerPath.toString()),
          SizedBox(height: 10),
          Text(
            widget.books.title.toString(),
            softWrap: true,
            style: TextStyle(fontSize: 18),
          ),
          Text(
          '( MRP : ₹ ' +  widget.books.regularPrice.toString()+ ', Selling Price : ₹ ' +widget.books.salePrice.toString()+' )',
            softWrap: true,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlaceOrderScreen(widget.books)
                  )
              );
            },
            text: getTranslated(context, StringConstant.buy)!,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              String data = json.encode(widget.books);
              String dynamicUrl = await FirebaseDynamicLinkService.createDynamicLink('books', data, '0');
              String shareContent =
                  'Get "' + widget.books.title.toString() + '" Book from Exampur Now.\n' +
                      dynamicUrl;
              Share.share(shareContent);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.share,
                  height: 15,
                  width: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  getTranslated(context, StringConstant.share)!,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
