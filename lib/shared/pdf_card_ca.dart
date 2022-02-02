import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class PDFCardCA extends StatefulWidget {
  final Data eBooks;
  final int index;

  const PDFCardCA(this.eBooks, this.index) : super();

  @override
  _PDFCardCAState createState() => _PDFCardCAState();
}

class _PDFCardCAState extends State<PDFCardCA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index % 2 == 0
          ? Theme.of(context).backgroundColor
          : AppColors.transparent,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width * 0.18,
                    child: Image.asset(Images.pdfIcon)),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Text(
                                widget.eBooks.title.toString(),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                )),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                        Text(
                        widget.eBooks.regular_price != 0 ?
                        '\u{20B9} ${widget.eBooks.regular_price.toString()}' : "",
                            style: TextStyle(fontSize: 15, decoration: TextDecoration.lineThrough)),

                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                if(widget.eBooks.sale_price == 0) {
                                  //view pdf
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Center(child: Text(
                                      widget.eBooks.sale_price != 0 ?
                                      '\u{20B9} ${widget.eBooks.sale_price.toString()}' : "View PDF",
                                      style: TextStyle(fontSize: 12))
                                  )
                              ),
                            ),
                            SizedBox(width: 10),
                            widget.eBooks.sale_price != 0 ?
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          DeliveryDetailScreen('Book', widget.eBooks.id.toString(),
                                              widget.eBooks.title.toString(), widget.eBooks.sale_price.toString()
                                          )
                                      ),
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: AppColors.red,
                                      ),
                                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: Center(child: Text("Buy Now", style: TextStyle(fontSize: 12, color: AppColors.white)))
                                  )
                                ) : SizedBox(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 600),
    this.pauseDuration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance!.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}
