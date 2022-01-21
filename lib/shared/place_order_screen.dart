import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatefulWidget {
  final Books books;

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
            child: AppConstants.image(widget.books.bannerPath.toString()),

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
              'Price Breakdown',
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
                  'Price',
                  softWrap: true,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '₹ ${widget.books.amount.toString()}',
                  softWrap: true,
                  style: TextStyle(fontSize: 14),
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
                  'Shipping Price',
                  softWrap: true,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '₹ 0',
                  softWrap: true,
                  style: TextStyle(fontSize: 14),
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
                  'Total Price',
                  softWrap: true,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '₹ ${widget.books.amount.toString()}',
                  softWrap: true,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomElevatedButton(
                onPressed: () {},
                text: "Place Order",
              ),
            ),
          ),
        ],
        // ),
      ),
    );
  }
}
