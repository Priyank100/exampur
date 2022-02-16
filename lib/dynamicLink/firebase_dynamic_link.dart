import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';

class FirebaseDynamicLinkService {
  static String uriPrefix = 'https://exampurflutter.page.link';
  static String site = 'https://www.exampur.com';
  static String packageName = 'com.example.exampur_mobile';
  static int minVersion = 1;

  static Future<String> createDynamicLink(Courses courseData, int courseType) async {
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        link: Uri.parse(site),
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: minVersion,
        // fallbackUrl: Uri.parse('url'),
      ),
      // iosParameters: IosParameters(
      //   bundleId: '',
      //   minimumVersion: '',
      //   appStoreId: '',
      //   fallbackUrl: Uri.parse('url')
      // ),
      // socialMetaTagParameters: SocialMetaTagParameters(
      //   title: '',
      //   description: '',
      //   imageUrl: Uri.parse('url')
      // )
    );
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    Uri url = shortLink.shortUrl;
    _linkMessage = url.toString();
    return _linkMessage;
  }

}