import 'package:flutter/material.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/moengage_inbox.dart';
import '../../utils/app_constants.dart';

class CardInbox extends StatefulWidget {
  const CardInbox({Key? key}) : super(key: key);

  @override
  State<CardInbox> createState() => _CardInboxState();
}

class _CardInboxState extends State<CardInbox> {
  MoEngageInbox moEngageInbox = MoEngageInbox();//UAIIRLJXLAVMA3I6TOFYHV8P-key
  InboxData? inboxData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCards();
  }

  Future<void> getCards() async {
    await moEngageInbox.fetchAllMessages().then((value) {
      inboxData = value;
      isLoading = false;
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading ? Center(child: CircularProgressIndicator()) :
      (inboxData == null && inboxData!.messages.isEmpty) ? AppConstants.noDataFound() :
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: inboxData!.messages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: AppConstants.image(
                            inboxData!.messages[index].media!.url.toString(),
                            boxfit: BoxFit.fill
                        )

                      // child: Image.network(
                      //   inboxData!.messages[index].media!.url.toString(),
                      //   fit: BoxFit.fill,
                      //   errorBuilder: (context, exception, stackTrace) {
                      //     return Image.asset(Images.no_image);
                      //   },
                      // ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(inboxData!.messages[index].textContent.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(inboxData!.messages[index].textContent.message, style: TextStyle(fontSize: 10)),
                            SizedBox(height: 5),
                            SizedBox(
                              height: 20,
                              child: ElevatedButton(
                                onPressed: () {
                                  bookNowPressed(index);
                                },
                                child: Text('Book Now', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void bookNowPressed(int index) {
  }
}

