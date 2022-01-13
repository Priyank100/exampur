import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/provider/locallization_provider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Container(
          width: 1170,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            children: [

              // SwitchListTile(
              //   value: Provider.of<ThemeProvider>(context).darkTheme,
              //   onChanged: (bool isActive) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
              //   title: Text(getTranslated('dark_theme', context), style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              // ),
              ListTile(
                leading: Icon(Icons.language, color: Theme.of(context).primaryColor),
                title: Text(getTranslated('VALLEY', context)!,),
                onTap:() => showDialog(
                  context: context,
                  builder: (ctx) => CurrencyDialog(),
              )
              // TitleButton(
              //   icon: Icons.language,
              //   title: getTranslated('choose_language', context),
              //   onTap: () => showAnimatedDialog(context, CurrencyDialog()),
              // ),
        )
         ] ),
        ),
      ),
    );
  }

}

class CurrencyDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int index;
    index = Provider.of<LocalizationProvider>(context, listen: false).languageIndex!;

    return Dialog(
      backgroundColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 300,
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text( 'language', ),
          ),

          // SizedBox(height: 150, child: Consumer<SplashProvider>(
          //   builder: (context, splash, child) {
          //     List<String> _valueList = [];
          //     AppConstants.languages.forEach((language) => _valueList.add(language.languageName!));
          //
          //     return CupertinoPicker(
          //       itemExtent: 40,
          //       useMagnifier: true,
          //       magnification: 1.2,
          //       scrollController: FixedExtentScrollController(initialItem: index = 0),
          //       onSelectedItemChanged: (int i) {
          //         index = i;
          //       },
          //       children: _valueList.map((value) {
          //         return Center(child: Text(value, style: TextStyle()));
          //       }).toList(),
          //     );
          //   },
          // )),

          Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, ),
          Row(children: [
            Expanded(child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel',)),
            )]),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: VerticalDivider(width: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: Theme.of(context).hintColor),
            ),
            Expanded(child: TextButton(
              onPressed: () {
                Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                   AppConstants.languages[index].languageCode!,
                   AppConstants.languages[index].countryCode,
                ));
                Navigator.pop(context);
              },
              child: Text('ok', )),

          ),

        ]),
      ),
    );
  }
}
