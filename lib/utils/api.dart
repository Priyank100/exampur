import 'app_constants.dart';

class API {
  // static String BASE_URL1 = 'https://auth.exampur.work/';
  // static String BASE_URL2 = 'https://static.exampur.work/';

  // static String BASE_URL1 = 'https://5asmwawww1.execute-api.ap-south-1.amazonaws.com/';
  // static String BASE_URL2 = 'https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/';

  // static String BASE_URL1 = 'https://7qclk4stsa.execute-api.ap-south-1.amazonaws.com/';
  // static String BASE_URL2 = 'https://seysl9nl99.execute-api.ap-south-1.amazonaws.com/';

  // static String BASE_URL1 = '';
  // static String BASE_URL2 = 'https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/';

  //Stage
  // static String BASE_URL1 = 'https://auth-stage.exampur.xyz/';
  // static String BASE_URL2 = 'https://static-stage.exampur.xyz/';

  //Dev
  // static String BASE_URL1 = 'https://auth-dev.exampur.xyz/';
  // static String BASE_URL2 = 'https://static-dev.exampur.xyz/';
  // static String BASE_URL2 = 'https://kubernetes.static.exampur.xyz/';

  //cache production
  static String BASE_URL1 = 'https://auth.exampurcache.xyz/';
  static String BASE_URL2 = 'https://static.exampurcache.xyz/';

  //Testing
 //static String BASE_URL1 = 'https://5asmwawww1.execute-api.ap-south-1.amazonaws.com/';

  //Testing
  // static String BASE_URL1 = 'https://5asmwawww1.execute-api.ap-south-1.amazonaws.com/';
  // static String BASE_URL2 = 'https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/';


  // call if BASE_URL1 got error-429
  static String BASE_URL1_U = 'https://qvjplseirk.execute-api.ap-northeast-1.amazonaws.com/';

  // base url for new module from web
  static String WEB_BASE_URL = 'https://exampur.com/api/';

  // base url for webview
  static String WEBVIEW_URL = 'https://exampur.com/e-app/login?token=TOKEN&path=/e-app/';

//=========================================================================================================//

  //BannerBase
  static String BANNER_BASE_URL = BASE_URL2 + 'get_cdn';

  //Auth
  static String Login_URL           = BASE_URL1 + 'auth/login';
  static String Valid_Token_URL     = BASE_URL1 + 'user';
  static String Update_User_URL     = BASE_URL1 + 'user';
  static String Change_Password_URL = BASE_URL1 + 'auth/changePassword';
  // static String Send_OTP_URL        = BASE_URL1 + 'otp';
  static String Reset_Password_URL  = BASE_URL1 + 'auth/resetPassword';
  static String Verify_OTP_URL      = BASE_URL1 + 'auth/verification';
  static String Send_OTP_URL        = 'http://sms.bitss.tech/api/v5/otp?template_id=624ecd020f1c701b4605cbb7&mobile=91USER_MOBILE&authkey=369403Ao8iwaB6hF624ecd56P1';

  static String Login_URL_2           = BASE_URL1_U + 'auth/login';
  static String Valid_Token_URL_2     = BASE_URL1_U + 'user';
  static String Update_User_URL_2     = BASE_URL1_U + 'user';
  static String Change_Password_URL_2 = BASE_URL1_U + 'auth/changePassword';
  static String Send_OTP_URL_2        = BASE_URL1_U + 'otp';
  static String Reset_Password_URL_2  = BASE_URL1_U + 'auth/resetPassword';
  static String Verify_OTP_URL_2      = BASE_URL1_U + 'auth/verification';

  //HomeBanner
  static String homeBanner_URL            = BASE_URL2 + 'banners';
  static String homeBannerCourselink_URL  = BASE_URL2 + 'courses/findone/';
  static String homeBannerbooklink_URL    = BASE_URL2 + 'books/findone/';
  static String homeBannerCombolink_URL   = BASE_URL2 + 'combo/findone/';

  //Category
  static String All_category_URL            = BASE_URL2 + 'category/all';
  static String Update_Choose_category_URL  = BASE_URL1 + 'user/updateCategory';
  static String Select_Choose_category_URL  = BASE_URL1 + 'user/getCategory';

  static String Update_Choose_category_URL_2  = BASE_URL1_U + 'user/updateCategory';
  static String Select_Choose_category_URL_2  = BASE_URL1_U + 'user/getCategory';

  //Book/E-Book
  static String Books_URL   = BASE_URL2 + 'books/printed/10/';
  static String E_Books_URL = BASE_URL2 + 'books/ebook/10/';

  //PaidCourse
  static String PaidCoursesTab_URL  = BASE_URL2 + 'category/course_paid';
  // static String PaidCoursesList_URL = BASE_URL2 + 'courses/paid/' + 'PAID_COURSE_ID' + '/10/';
  static String PaidCoursesList_URL = TEST_BASE_URL + 'courses/paid/' + 'PAID_COURSE_ID' + '/10/';

  //FreeCourse
  static String FreeCoursesTab_URL  = BASE_URL2 + 'category/course_free';
  static String FreeCoursesList_URL = BASE_URL2 + 'courses/free/' + 'FREE_COURSE_ID' + '/10/';

  //one2one
  static String One2One_URL         = BASE_URL2 + 'courses/onetoone/10/';
  static String TermsConditions_URL = 'https://exampur.com/';
  static String PrivacyPolicy_URL   = 'buy.exampur.xyz/disclaimer';

  //offlineBatches
  static String offline_batches         = BASE_URL2 + 'offline_centers/findall/10/';
  static String offline_batches_center  = BASE_URL2 + 'offline_centers/findone/' + 'CENTER_ID' + '/10/';
  static String offline_batches_course  = BASE_URL2 + 'offline_centers/course/' + 'COURSE_ID';

  //appTutorial
  static String AppTutorial_URL = BASE_URL2 + 'tutorials/app';

  //helpandfeedback
  static String HelpFeedback_URL    = BASE_URL1 + 'ticket/create';

  static String HelpFeedback_URL_2  = BASE_URL1_U + 'ticket/create';

  //order_course
  // static String order_course          = BASE_URL1 + 'order_course/create';
  static String finalize_order_course = BASE_URL1 + 'order_course/finalize';

  static String order_course_2          = BASE_URL1_U + 'order_course/create';
  static String finalize_order_course_2 = BASE_URL1_U + 'order_course/finalize';

  //order_combo_course
  // static String order_combo_course          = BASE_URL1 + 'order_combo_course/create';
  static String finalize_order_combo_course = BASE_URL1 + 'order_combo_course/finalize';

  static String order_combo_course_2          = BASE_URL1_U + 'order_combo_course/create';
  static String finalize_order_combo_course_2 = BASE_URL1_U + 'order_combo_course/finalize';

  //order_book
  static String order_book          = BASE_URL1 + 'order_book/create';
  static String finalize_order_book = BASE_URL1 + 'order_book/finalize';

  static String order_book_2          = BASE_URL1_U + 'order_book/create';
  static String finalize_order_book_2 = BASE_URL1_U + 'order_book/finalize';

  //order_testSeries
  static String order_test_series          = BASE_URL1 + 'order_testseries/create';
  static String finalize_order_test_series = BASE_URL1 + 'order_testseries/finalize';

  static String order_test_series_2          = BASE_URL1_U + 'order_testseries/create';
  static String finalize_order_test_series_2 = BASE_URL1_U + 'order_testseries/finalize';

  //coupon
  static String CouponCode_URL    = BASE_URL1 + 'promo_code/';

  static String CouponCode_URL_2  = BASE_URL1_U + 'promo_code/';

  //demo
  static String Demo_URL = BASE_URL2 + 'course_timeline_demo';

  //jobAlerts
  static String job_alerts_tab_URL      = BASE_URL2 + 'alert/categories';
  static String job_alerts_list_URL     = BASE_URL2 + 'alert/findall/' + 'ALERT_CATEGORY_ID' + '/' + 'ENCODE_CATEGORY' + '/10/';
  static String job_alerts_details_URL  = BASE_URL2 + 'alert/findone/' + 'ALERT_ID';

  //current_affairs
  static String ca_sm_url = BASE_URL2 + 'content/findall/' + 'CONTENT_CATEGORY_ID' + '/' + 'TYPE' + '/' + 'ENCODE_CATEGORY' + '/10/';

  //CaBytes
  static String ca_bytes_url   = BASE_URL2 + 'ca_byte/' + 'ENCODE_CATEGORY' + '/10/';

  //my_purchase
  static String mypurchase  = BASE_URL1 + 'mypurchase/findall';
  static String myinvoice   = BASE_URL1 + 'mypurchase/findone/';

  static String mypurchase_2  = BASE_URL1_U + 'mypurchase/findall';
  static String myinvoice_2   = BASE_URL1_U + 'mypurchase/findone/';

  //my_course
  static String myCourse_URL                      = BASE_URL1 + 'mycourses';
  static String myCourse_subject_URL              = BASE_URL1 + 'course_subject/';
  static String myCourse_material_URL             = BASE_URL1 + 'course_material/material/';
  static String myCourse_chapter_URL              = BASE_URL1 + 'course_material/chapter/';
  // static String myCourse_timeline_URL             = BASE_URL1 + 'course_timeline';
  static String myCourse_timelineshareStream_URL  = BASE_URL1 + 'course_timeline/shareStreamToMobile';
  static String myCourse_notification_URL         = BASE_URL1 + 'course_notification';
  static String myCourse_timeline_live_URL        = BASE_URL1 + 'course_timeline/live';
  static String myCourse_timeline_upcoming_URL    = BASE_URL1 + 'course_timeline/upcoming';

  //testSeries
  static String allTestSeries_URL   = BASE_URL2 + 'test_series';
  static String liveTestSeries_URL  = BASE_URL2 + 'live_testseries';
  static String myTestSeries_URL    = BASE_URL1 + 'testseries/enrolled/get_my_testseries';
  // static String testSeriesWeb_URL  = 'https://exampurtest.vercel.app/testseries/list/' + 'TEST_SERIES_ID' + '?auth_token=' + 'AUTH_TOKEN';
  static String testSeriesWeb_URL   = 'https://testweb.exampur.xyz/' + 'TESTSERIES_ID'+'/list' + '?auth_token=' + 'AUTH_TOKEN';


  //dailyQuiz
  static String dailyQuiz_URL         = BASE_URL2 + 'quiz/find_all_quiz?page_id=';
  // static String dailyQuiz_web_URL  = 'https://test.exampur.xyz/quiz/' + 'QUIZ_ID' + '?auth_token=' + 'AUTH_TOKEN';
  static String dailyQuiz_web_URL     = 'https://testweb.exampur.xyz/quiz/' + 'QUIZ_ID' + '?auth_token=' + 'AUTH_TOKEN';

  //study Material New
  static String studyMaterialNewUrl       = WEB_BASE_URL + 'study-material/';
  static String studyMaterialNewSubCatUrl = WEB_BASE_URL + 'download-material/' + 'ID';

  //Previous Year PDF
  static String previousYearMaterialUrl   = WEB_BASE_URL + 'previous-year-material/';

  // Current Affairs New
  static String currentAffairsNewTabUrl         = WEB_BASE_URL + 'current-affairs/sub-category/';
  static String currentAffairsNewListUrl        = WEB_BASE_URL + 'content-module-list/' + 'ID';
  static String currentAffairsNewDetailUrl      = WEB_BASE_URL + 'current-affairs-article/' + 'ID';
  static String currentAffairsNewTagListUrl     = WEB_BASE_URL + 'current-affairs-tag-list/';
  static String currentAffairsNewListFilterUrl  = WEB_BASE_URL + 'search-news/?';

  //Practice Question
  static String practiceQuestionCategoriesUrl       = WEB_BASE_URL + 'practice-categories/';
  static String practiceQuestionViaCatAndSubCatUrl  = WEB_BASE_URL + 'practice-question-api/';

  //Job Notification - https://exampur.com/api/
  static String jobNotificationCoursesUrl     = WEB_BASE_URL + 'courses/';
  static String jobNotificationTagUrl         = WEB_BASE_URL + 'exam-job-tag/';
  static String jobNotificationListingUrl     = WEB_BASE_URL + 'job-notification/' + 'TAG_SLUG' + '/' + 'COURSE_ID';
  static String jobNotificationDetailUrl      = WEB_BASE_URL + 'job-detail/';

  // Study_Notes
  static String studyNotesUrl                   = WEB_BASE_URL + 'study-notes-exam/';
  static String studyNotesSubjectUrl            = WEB_BASE_URL + 'study-notes-subject/' + 'COURSE_ID';
  static String studyNotesChapterUrl            = WEB_BASE_URL + 'study-notes-chapter/' + 'COURSE_ID';
  static String studyNotesChapterDescriptionUrl = WEB_BASE_URL + 'study-notes-detail/' + 'COURSE_ID';

  //free Videos
  static String freeVideoUrl        = WEB_BASE_URL + 'free-videos-exam-category/';
  static String freeVideoListUrl    = WEB_BASE_URL + 'free-videos-subject/' + 'SUBJECT_ID';
  static String freeVideoContentUrl = WEB_BASE_URL + 'free-videos-content/' + 'SUBJECT_ID';


  //testSeriesWebUrl
  static String testSeriesWebUrl        = WEBVIEW_URL + 'test-series/?lang=langCode';
  static String liveTestWebUrl          = WEBVIEW_URL + 'live-tests/?lang=langCode';
  static String quizzesWebUrl           = WEBVIEW_URL + 'short-quiz/?lang=langCode';
  static String attemptTestWebUrl       = WEBVIEW_URL + 'attempted-test/?lang=langCode';
  static String attemptQuizzesWebUrl    = WEBVIEW_URL + 'attempted-quiz/?lang=langCode';
  static String savedQuestionWebUrl     = WEBVIEW_URL + 'saved-question/?lang=langCode';


  //order course and combo course with upsell book
  static String order_course_with_upsell = BASE_URL1 + 'order_course/upsell_create';

  // order upsell book after finalize
  static String order_create_upsell = BASE_URL1 + 'order_course/store_upsell_order';

  // emi
  static String order_course_with_emi = BASE_URL1 + 'order_course/emi_create';

  //service log
  static String serviceLogUrl = 'https://elastic.exampur.xyz/api/v1/service/log';


  //pre-booking
  static String preBookOptedUrl = BASE_URL1 +'prebook-course/COURSE_ID';


  //doubts
  static String doubtsUrl = WEBVIEW_URL +'doubt-session/id?purchase=TF';

//================================== New My Course ===============================================

  static String TEST_BASE_URL = 'https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/';

  // bottomSheet
  static String bottomSheet_URL                     = '';

  // timeline - Live = https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/sampling/class/live/:course_id
  static String newMyCourseTimelineLive_URL         = TEST_BASE_URL + 'sampling/class/live/';

  // timeline - Upcoming = https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/sampling/class/upcoming/:course_id
  static String newMyCourseTimelineUpcoming_URL     = TEST_BASE_URL + 'sampling/class/upcoming/';

  // timeline - live video watch
  static String newMyCourseTimelineShareStream_URL  = BASE_URL1 + 'course_timeline/shareStreamToMobile';

  // subject list = https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/sampling/subject/:course_id
  static String newMyCourseSubjects_URL             = TEST_BASE_URL + 'sampling/subject/';

  // chapter list = https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/sampling/chapter/:subject_id/:course_id
  static String newMyCourseChapters_URL             = TEST_BASE_URL + 'sampling/chapter/';

  // topic list = https://alvf81kry3.execute-api.ap-south-1.amazonaws.com/sampling/material/:subject_id/:course_id/:chapter_name
  static String newMyCourseTopics_URL               = TEST_BASE_URL + 'sampling/material/';

//----------------------------------------------------------------------------------------------------

}