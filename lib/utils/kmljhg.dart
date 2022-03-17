// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import 'appBar.dart';
//
// class MovieVideoPlay extends StatefulWidget {
//  // final String url;
//  // const MovieVideoPlay({Key key, this.url}) : super(key: key);
//   @override
//   _MovieVideoPlayState createState() => _MovieVideoPlayState();
// }
// class _MovieVideoPlayState extends State<MovieVideoPlay> {
//   late VideoPlayerController videoPlayerController;
//   late ChewieController chewieController;
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       aspectRatio: 3 / 2,
//       autoPlay: true,
//       looping: true,
//     );
//   }
//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 8),
//             height: 250,
//             child: Chewie(
//                     controller: chewieController
//                 ),
//           ),
//
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child:   Text('kjhgfdsfghjk'),
// )
//
//         ],
//       ),
//     );
//   }
// }
//
//
//
