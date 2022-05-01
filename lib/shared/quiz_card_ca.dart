import 'package:exampur_mobile/data/model/test_series_model.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizCardCA extends StatefulWidget {
  final Data testSeriesData;
  const QuizCardCA(this.testSeriesData) : super();

  @override
  _QuizCardCAState createState() => _QuizCardCAState();
}

class _QuizCardCAState extends State<QuizCardCA> {

  @override
  Widget build(BuildContext context) {
    return  Container(
     // padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(64, 64, 64, 0.12), blurRadius: 16)
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          color: AppColors.transparent,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Padding(
               padding: EdgeInsets.all(5),
               child: Text(widget.testSeriesData.title.toString(),
                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                   maxLines: 2,
                   softWrap: true,
                   overflow: TextOverflow.ellipsis
               ),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Flexible(
                   child: Column(
                     children: [
                       Padding(
                         padding: EdgeInsets.only(left: 10),
                         child: Text('\u2713 ${widget.testSeriesData.description.toString()}',
                             style: TextStyle(fontSize: 12)),
                       ),
                     ],
                   ),
                 ),
                 Padding(
                     padding: EdgeInsets.all(5),
                   // child: Image.asset(Images.exampur_logo,height: 50)
                   child: widget.testSeriesData.image.toString().contains('http') ?
                   AppConstants.image(widget.testSeriesData.image.toString(), height: 60.0) :
                   AppConstants.image(AppConstants.BANNER_BASE + widget.testSeriesData.image.toString(), height: 60.0)
                 )
               ],
             ),
             SizedBox(height: 5),
             Align(
               alignment: FractionalOffset.bottomCenter,
               child: InkWell(
                 onTap: () {

                   AppConstants.goTo(context, DeliveryDetailScreen('TestSeries', widget.testSeriesData.id.toString(),
                       widget.testSeriesData.title.toString(), widget.testSeriesData.salePrice.toString()
                   ));
                 },
                 child: Container(
                   height: 40,
                   alignment: Alignment.center,
                   decoration: const BoxDecoration(
                     color: AppColors.amber,
                     borderRadius: BorderRadius.only(
                       bottomRight: Radius.circular(5),
                       bottomLeft: Radius.circular(5),
                     ),
                   ),
                   child: Text('BUY NOW', style: TextStyle(color: AppColors.white)),
                 ),
               ),
             ),
           ],
         ),
        ),

    );
  }
}
