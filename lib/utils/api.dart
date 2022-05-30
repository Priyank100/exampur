class API {

  static const String BASE_URL  = 'https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io/';
  // static const String BASE_URL2 = 'https://auth.exampur.work/';
  // static const String BASE_URL3 = 'https://static.exampur.work/';

  // static const String BASE_URL2 = 'https://5asmwawww1.execute-api.ap-south-1.amazonaws.com/';
  // static const String BASE_URL3 = 'https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/';

  // static const String BASE_URL2 = 'https://5asmwawww1.execute-api.ap-south-1.amazonaws.com/';
  // static const String BASE_URL3 = 'https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/';

  //Stage
  // static const String BASE_URL2 = 'https://auth-stage.exampur.xyz/';
  // static const String BASE_URL3 = 'https://static-stage.exampur.xyz/';

  //Dev
  // static const String BASE_URL2 = 'https://auth-dev.exampur.xyz/';
  // static const String BASE_URL3 = 'https://static-dev.exampur.xyz/';
  // static const String BASE_URL3 = 'https://kubernetes.static.exampur.xyz/';

  //cache production
  static const String BASE_URL2 = 'https://auth.exampurcache.xyz/';
  static const String BASE_URL3 = 'https://static.exampurcache.xyz/';

  // call if BASE_URL2 got error-429
  static const String BASE_URL4 = 'https://qvjplseirk.execute-api.ap-northeast-1.amazonaws.com/';

  // base url for new module from web
  static const String WEB_BASE_URL = 'https://exampur.com/api/';

//=========================================================================================================//

  //BannerBase
  static const String BANNER_BASE_URL = BASE_URL3 + 'get_cdn';

  //Auth
  static const String Login_URL           = BASE_URL2 + 'auth/login';
  static const String Valid_Token_URL     = BASE_URL2 + 'user';
  static const String Update_User_URL     = BASE_URL2 + 'user';
  static const String Change_Password_URL = BASE_URL2 + 'auth/changePassword';
  // static const String Send_OTP_URL        = BASE_URL2 + 'otp';
  static const String Reset_Password_URL  = BASE_URL2 + 'auth/resetPassword';
  static const String Verify_OTP_URL      = BASE_URL2 + 'auth/verification';
  static const String Send_OTP_URL        = 'http://sms.bitss.tech/api/v5/otp?template_id=624ecd020f1c701b4605cbb7&mobile=91USER_MOBILE&authkey=369403Ao8iwaB6hF624ecd56P1';

  static const String Login_URL_2           = BASE_URL4 + 'auth/login';
  static const String Valid_Token_URL_2     = BASE_URL4 + 'user';
  static const String Update_User_URL_2    = BASE_URL4 + 'user';
  static const String Change_Password_URL_2 = BASE_URL4 + 'auth/changePassword';
  static const String Send_OTP_URL_2        = BASE_URL4 + 'otp';
  static const String Reset_Password_URL_2  = BASE_URL4 + 'auth/resetPassword';
  static const String Verify_OTP_URL_2      = BASE_URL4 + 'auth/verification';

  //HomeBanner
  static const String homeBanner_URL            = BASE_URL3 + 'banners';
  static const String homeBannerCourselink_URL  = BASE_URL3 + 'courses/findone/';
  static const String homeBannerbooklink_URL    = BASE_URL3 + 'books/findone/';
  static const String homeBannerCombolink_URL   = BASE_URL3 + 'combo/findone/';

  //Category
  static const String All_category_URL         = BASE_URL3 + 'category/all';
  static const String Update_Choose_category_URL  = BASE_URL2 + 'user/updateCategory';
  static const String Select_Choose_category_URL  = BASE_URL2 + 'user/getCategory';

  static const String Update_Choose_category_URL_2  = BASE_URL4 + 'user/updateCategory';
  static const String Select_Choose_category_URL_2  = BASE_URL4 + 'user/getCategory';

  //Book/E-Book
  static const String Books_URL   = BASE_URL3 + 'books/printed/10/';
  static const String E_Books_URL = BASE_URL3 + 'books/ebook/10/';

  //PaidCourse
  static const String PaidCoursesTab_URL  = BASE_URL3 + 'category/course_paid';
  static const String PaidCoursesList_URL = BASE_URL3 + 'courses/paid/' + 'PAID_COURSE_ID' + '/10/';

  //FreeCourse
  static const String FreeCoursesTab_URL  = BASE_URL3 + 'category/course_free';
  static const String FreeCoursesList_URL = BASE_URL3 + 'courses/free/' + 'FREE_COURSE_ID' + '/10/';

  //one2one
  static const String One2One_URL         = BASE_URL3 + 'courses/onetoone/10/';
  static const String TermsConditions_URL = 'https://exampur.com/';

  //offlineBatches
  static const String offline_batches         = BASE_URL3 + 'offline_centers/findall/10/';
  static const String offline_batches_center  = BASE_URL3 + 'offline_centers/findone/' + 'CENTER_ID' + '/10/';
  static const String offline_batches_course  = BASE_URL3 + 'offline_centers/course/' + 'COURSE_ID';

  //appTutorial
  static const String AppTutorial_URL = BASE_URL3 + 'tutorials/app';

  //helpandfeedback
  static const String HelpFeedback_URL = BASE_URL2 + 'ticket/create';

  static const String HelpFeedback_URL_2 = BASE_URL4 + 'ticket/create';

  //order_course
  static const String order_course          = BASE_URL2 + 'order_course/create';
  static const String finalize_order_course = BASE_URL2 + 'order_course/finalize';

  static const String order_course_2          = BASE_URL4 + 'order_course/create';
  static const String finalize_order_course_2 = BASE_URL4 + 'order_course/finalize';

  //order_combo_course
  static const String order_combo_course          = BASE_URL2 + 'order_combo_course/create';
  static const String finalize_order_combo_course = BASE_URL2 + 'order_combo_course/finalize';

  static const String order_combo_course_2          = BASE_URL4 + 'order_combo_course/create';
  static const String finalize_order_combo_course_2 = BASE_URL4 + 'order_combo_course/finalize';

  //order_book
  static const String order_book          = BASE_URL2 + 'order_book/create';
  static const String finalize_order_book = BASE_URL2 + 'order_book/finalize';

  static const String order_book_2          = BASE_URL4 + 'order_book/create';
  static const String finalize_order_book_2 = BASE_URL4 + 'order_book/finalize';

  //order_testSeries
  static const String order_test_series          = BASE_URL2 + 'order_testseries/create';
  static const String finalize_order_test_series = BASE_URL2 + 'order_testseries/finalize';

  static const String order_test_series_2          = BASE_URL4 + 'order_testseries/create';
  static const String finalize_order_test_series_2 = BASE_URL4 + 'order_testseries/finalize';

  //coupon
  static const String CouponCode_URL = BASE_URL2 +'promo_code/';

  static const String CouponCode_URL_2 = BASE_URL4 +'promo_code/';

  //demo
  static const String Demo_URL = BASE_URL3 +'course_timeline_demo';

  //jobAlerts
  static const String job_alerts_tab_URL      = BASE_URL3 +'alert/categories';
  static const String job_alerts_list_URL     = BASE_URL3 +'alert/findall/' + 'ALERT_CATEGORY_ID' + '/' + 'ENCODE_CATEGORY' + '/10/';
  static const String job_alerts_details_URL  = BASE_URL3 +'alert/findone/' + 'ALERT_ID';

  //current_affairs
  static const String ca_sm_url = BASE_URL3 + 'content/findall/' + 'CONTENT_CATEGORY_ID' + '/' + 'TYPE' + '/' + 'ENCODE_CATEGORY' + '/10/';

  //CaBytes
  static const String ca_bytes_url   = BASE_URL3+ 'ca_byte/' + 'ENCODE_CATEGORY' + '/10/';

  //my_purchase
  static const String mypurchase  = BASE_URL2 + 'mypurchase/findall';
  static const String myinvoice   = BASE_URL2 + 'mypurchase/findone/';

  static const String mypurchase_2  = BASE_URL4 + 'mypurchase/findall';
  static const String myinvoice_2   = BASE_URL4 + 'mypurchase/findone/';

  //my_course
  static const String myCourse_URL              = BASE_URL2 + 'mycourses';
  static const String myCourse_subject_URL      = BASE_URL2 + 'course_subject/';
  static const String myCourse_material_URL     = BASE_URL2 + 'course_material/material/';
  static const String myCourse_chapter_URL     = BASE_URL2 + 'course_material/chapter/';
  // static const String myCourse_timeline_URL     = BASE_URL2 + 'course_timeline';
  static const String myCourse_timelineshareStream_URL   = BASE_URL2 + 'course_timeline/shareStreamToMobile';
  static const String myCourse_notification_URL = BASE_URL2 + 'course_notification';
  static const String myCourse_timeline_live_URL     = BASE_URL2 + 'course_timeline/live';
  static const String myCourse_timeline_upcoming_URL     = BASE_URL2 + 'course_timeline/upcoming';

  //testSeries
  static const String allTestSeries_URL   = BASE_URL3 + 'test_series';
  static const String liveTestSeries_URL  = BASE_URL3 + 'live_testseries';
  static const String myTestSeries_URL    = BASE_URL2 + 'testseries/enrolled/get_my_testseries';
  // static const String testSeriesWeb_URL  = 'https://exampurtest.vercel.app/testseries/list/' + 'TEST_SERIES_ID' + '?auth_token=' + 'AUTH_TOKEN';
  // https://testweb.exampur.xyz/TESTSERIES_ID/list?auth_token=AUTH_TOKE
  static const String testSeriesWeb_URL  = 'https://testweb.exampur.xyz/' + 'TESTSERIES_ID'+'/list' + '?auth_token=' + 'AUTH_TOKEN';


  //dailyQuiz
  static const String dailyQuiz_URL  = BASE_URL3 + 'quiz/find_all_quiz?page_id=';
  // static const String dailyQuiz_web_URL  = 'https://test.exampur.xyz/quiz/' + 'QUIZ_ID' + '?auth_token=' + 'AUTH_TOKEN';
  static const String dailyQuiz_web_URL  = 'https://testweb.exampur.xyz/quiz/' + 'QUIZ_ID' + '?auth_token=' + 'AUTH_TOKEN';

  //study Material New - https://exampur.com/api/
  static const String studyMaterialNewUrl       = WEB_BASE_URL + 'study-material/';
  static const String studyMaterialNewSubCatUrl = WEB_BASE_URL + 'download-material/';

  //Previous Year PDF
  static const String previousYearMaterialUrl   = WEB_BASE_URL + 'previous-year-material/';

  // Current Affairs New
  static const String currentAffairsNewTabUrl   = WEB_BASE_URL + 'current-affairs/sub-category/';
  static const String currentAffairsNewListUrl  = WEB_BASE_URL + 'content-module-list/';

}