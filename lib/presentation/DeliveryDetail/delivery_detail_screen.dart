import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({Key? key}) : super(key: key);

  @override
  _DeliveryDetailScreenState createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // resizeToAvoidBottomInset: false,
       // resizeToAvoidBottomPadding: false,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
              'Provide Further Detalis for Delivery of Books',
              maxLines: 2,
              style: TextStyle(fontSize: 25),
            )),
            //Flexible(child: Text('Provide Further Detalis for Delivery of Course',maxLines:2,style: TextStyle(fontSize: 25),)),
            SizedBox(
              height: 20,
            ),
            TextUse(
              image: Icons.person,
              title: 'Name',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Full name",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.person,
              title: 'Care of/Son of',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Care of/Son of",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.phone,
              title: 'Phone Number',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Phone Number",
              //focusNode: _phoneNode,
              textInputType: TextInputType.number,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.phone,
              title: ' Alternate Phone Number',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Alternate Phone Number",
              //focusNode: _phoneNode,
              textInputType: TextInputType.number,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: 'House no./Village',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Address",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: 'Post',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Post",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),

            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: 'City',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter City",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: 'Landmark / Teshil',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Landmark",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: 'State',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter State",
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: 'Pin Code',
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Enter Pin Code",
              //focusNode: _phoneNode,
              textInputType: TextInputType.number,
              //controller: _phoneController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: Colors.amber),

                child: Center(
                    child: Text(
                  'Continue to Buy Course',
                  style: TextStyle(color: Colors.white,fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextUse extends StatelessWidget {
  final IconData? image;
  final String? title;

  TextUse({
    this.image,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          image,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title!,
          style: TextStyle(),
        ),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }
}
