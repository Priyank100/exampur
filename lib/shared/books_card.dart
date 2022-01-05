import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BooksCard extends StatefulWidget {
  final List<Books> booksList;
  final int index;

  const BooksCard(this.booksList, this.index) : super();

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
            color: Colors.grey,
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
          // Image.network(
          //   widget.list[widget.index].bannerPath.toString(),
          //   fit: BoxFit.fill,
          //   loadingBuilder: (BuildContext context, Widget child,
          //       ImageChunkEvent? loadingProgress) {
          //     if (loadingProgress == null) return child;
          //     return Center(
          //       child: CircularProgressIndicator(
          //         value: loadingProgress.expectedTotalBytes != null
          //             ? loadingProgress.cumulativeBytesLoaded /
          //             loadingProgress.expectedTotalBytes!
          //             : null,
          //       ),
          //     );
          //   },
          // ),
          CachedNetworkImage(
            imageUrl: widget.booksList[widget.index].bannerPath.toString(),
            // placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.booksList[widget.index].title.toString(),
            softWrap: true,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          CustomElevatedButton(
            onPressed: () {},
            text: "Buy Now",
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              String shareContent =
                  'Get "' +
                  widget.booksList[widget.index].title.toString() +
                  '" Book from Exampur Now.\n' +
                  'https://exampur.com/';
              // Share.share(shareContent);
              Share.shareFiles([widget.booksList[widget.index].logoPath.toString()], text: shareContent);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.share,
                  height: 15,
                  width: 20,
                ),
                // Icon(
                //   Icons.share,
                //   size: 23,
                //   color: Colors.black,
                // ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Share",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
