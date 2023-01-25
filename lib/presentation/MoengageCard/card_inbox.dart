import 'package:flutter/material.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/moengage_inbox.dart';

class CardInbox extends StatefulWidget {
  const CardInbox({Key? key}) : super(key: key);

  @override
  State<CardInbox> createState() => _CardInboxState();
}

class _CardInboxState extends State<CardInbox> {
  MoEngageInbox _moEngageInbox = MoEngageInbox('');
  InboxData? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCards();
  }

  Future<void> getCards() async {
    data = await _moEngageInbox.fetchAllMessages();
    print('>>>>>>>>>>' + data!.messages.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
