import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/my_purchase_model.dart';
import 'invoicePage.dart';

class PurchaseListContainer extends StatefulWidget {
  final Data mypurchaseData;

  const PurchaseListContainer(this.mypurchaseData,);

  @override
  _PurchaseListContainerState createState() => _PurchaseListContainerState();
}

class _PurchaseListContainerState extends State<PurchaseListContainer> {
  @override
  Widget build(BuildContext context) {
   // print(AppConstants.BANNER_BASE + widget.mypurchaseData.product!.bannerPath.toString());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              AppConstants.printLog("tapped");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all( Radius.circular(10),
                    // bottomRight: Radius.circular(20),
                    // bottomLeft: Radius.circular(20),
                  ),
                  child: Container(
                    //padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: double.infinity,
                    // child: CachedNetworkImage(
                    //   imageUrl: AppConstants.BANNER_BASE + widget.courseData.bannerPath.toString(),
                    //   placeholder: (context, url) => new Image.asset(Images.noimage),
                    //   errorWidget: (context, url, error) => new Icon(Icons.error),
                    // ),
                   // child: Image.asset(Images.exampur_logo),
                    child: AppConstants.image(AppConstants.BANNER_BASE + widget.mypurchaseData.product!.bannerPath.toString()),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                      widget.mypurchaseData.product!.title.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                            // Text(
                            //  'data',
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: TextStyle(fontSize: 18),
                            // ),
                          ],
                        ),
                      ),
                      // ClipOval(
                      //   clipper: MyClip(),
                      //   child: FadeInImage.assetNetwork(
                      //     placeholder: Images.noimage,
                      //     image: widget.paidcourseList[widget.index].logoPath.toString(),
                      //
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      // ClipOval(
                      //   child: Image.asset(
                      //     Images.exampur_logo,
                      //     height: 50,
                      //     width: 50,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:12,right: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          CustomRoundButton(text: getTranslated(context, StringConstant.viewInvoice)!, onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                InvoiceDetailPage(widget.mypurchaseData.id.toString(),widget.mypurchaseData.product!.type.toString(),)
                            ));
                          },)
                        ],
                      ),

                    ],),
                ),
              
              ],
            ),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
