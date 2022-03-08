import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/BookBannerDetail.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/banner_detail_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BannerLinkBookDetailPage extends StatefulWidget {
  String type;
  final datalink;
  BannerLinkBookDetailPage(this.type, this.datalink) ;

  @override
  _BannerLinkBookDetailPageState createState() => _BannerLinkBookDetailPageState();
}

class _BannerLinkBookDetailPageState extends State<BannerLinkBookDetailPage> {
  Book? bannerDetailData;
  bool isLoading=false;
  Future<void> getLists() async {
    isLoading=true;

      bannerDetailData= (await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannnerBookDetail(context, widget.datalink.toString()))! ;

    isLoading=false;
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:bannerDetailData==null?Center(child: CircularProgressIndicator(color: AppColors.amber,)):
        BookBannerDetail(bannerDetailData)
        // Viedobanner(bannerDetailData!.videoPath.toString(), bannerDetailData!.title.toString(), bannerDetailData!.id.toString(), bannerDetailData!.salePrice.toString(),)

    );
  }
}



class BookBannerDetail extends StatefulWidget {
  Book? bookDetailData;
  BookBannerDetail(this.bookDetailData) : super();

  @override
  _BookBannerDetailState createState() => _BookBannerDetailState();
}

class _BookBannerDetailState extends State<BookBannerDetail> {
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
            child: AppConstants.image(AppConstants.BANNER_BASE +widget.bookDetailData!.bannerPath.toString()),

          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.bookDetailData!.title.toString(),
              softWrap: true,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.bookDetailData!.description.toString(),
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
                  '₹ ${widget.bookDetailData!.regularPrice.toString()}',
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
                  '₹ ${widget.bookDetailData!.salePrice.toString()}',
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
                  '₹ ${widget.bookDetailData!.salePrice.toString()}',
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
                        DeliveryDetailScreen('Book', widget.bookDetailData!.id.toString(),
                            widget.bookDetailData!.title.toString(), widget.bookDetailData!.salePrice.toString()
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

