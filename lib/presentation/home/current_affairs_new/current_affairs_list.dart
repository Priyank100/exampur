import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'current_affairs_details.dart';

class CurrentAffairsList extends StatefulWidget {
  const CurrentAffairsList({Key? key}) : super(key: key);

  @override
  State<CurrentAffairsList> createState() => _CurrentAffairsListState();
}

class _CurrentAffairsListState extends State<CurrentAffairsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 8),
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.grey200,
              border: Border.all(color: AppColors.grey, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              autocorrect: false,
              onChanged: (s) {
                },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },

              cursorColor: AppColors.amber,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,size: 25,color: AppColors.grey400),
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: AppColors.grey400,
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 10),
                isDense: true,
                counterText: '',
                errorStyle: TextStyle(height: 1.5),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Expanded(
            child:DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: tabBar(),
            )),
      ],),
    );
  }
  Widget tabBar() {
    return  Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TabBar(
          onTap: (i){
            FocusScope.of(context).unfocus();
          },
          tabs: [
            Tab(
              text:'Daily' ,

            ),
            Tab(
              text:'Daily' ,
            ),
            Tab(
              text:'Daily' ,
            ),

          ],
          indicatorColor: AppColors.amber,
          padding: EdgeInsets.all(8),
        ),
        Expanded(
          child: TabBarView(children: [
            DataContainer(),
            DataContainer(),
            DataContainer(),


          ],),
        ),

      ],

    );
  }
  Widget DataContainer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Daily Current Affairs',style: TextStyle(fontSize: 15),),
            InkWell(onTap:(){
              FocusScope.of(context).unfocus();
            },child: FaIcon(FontAwesomeIcons.calendarAlt,size: 20,),)
          ],),
        ),
      Expanded(
        child: ListView.builder(
            itemCount:10,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ListItem(index);
            }),
      ),
   ] );
  }

  Widget ListItem(index){
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (_) =>
                CurrentAffairsDetails()));

      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
            children: [
              Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width/3,
                  child:Image.asset(Images.exampur_logo,fit: BoxFit.fill),

                      ),
              SizedBox(width: 5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title',style: TextStyle(fontSize: 12)),
                    Text('Date',style: TextStyle(fontSize: 10,color: AppColors.amber)),
                    Text('Descrition',maxLines: 3,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,))
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
