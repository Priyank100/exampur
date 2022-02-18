import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

class PlaceOrderScreen extends StatefulWidget {
  final BookEbook books;

  const PlaceOrderScreen(this.books) : super();

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: AppConstants.image(AppConstants.BANNER_BASE +widget.books.bannerPath.toString()),

          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.books.title.toString(),
              softWrap: true,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.books.description.toString(),
              softWrap: true,
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              getTranslated(context,StringConstant.priceBreakdown)!,
              softWrap: true,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context,StringConstant.Price)!,
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
                  getTranslated(context,StringConstant.sellingPrice)!,
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
            padding: const EdgeInsets.all(8.0),
            child: Divider(thickness: 1,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, StringConstant.TotalAmount)!,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        DeliveryDetailScreen('Book', widget.books.id.toString(),
                            widget.books.title.toString(), widget.books.salePrice.toString()
                        )
                    ),
                  );
                },
                text:getTranslated(context, StringConstant.placeOrder)!,
              ),
            ),
          ),
        ],
        // ),
      ),
    );
  }
}
