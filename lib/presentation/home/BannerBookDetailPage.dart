import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
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
  Data? bannerDetailData;
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
        ViewPdf(AppConstants.BANNER_BASE + widget.datalink.toString())
        // Viedobanner(bannerDetailData!.videoPath.toString(), bannerDetailData!.title.toString(), bannerDetailData!.id.toString(), bannerDetailData!.salePrice.toString(),)

    );
  }
}



class BookDetailpdf extends StatefulWidget {
  const BookDetailpdf({Key? key}) : super(key: key);

  @override
  _BookDetailpdfState createState() => _BookDetailpdfState();
}

class _BookDetailpdfState extends State<BookDetailpdf> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
