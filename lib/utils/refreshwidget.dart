import 'dart:io';

import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState>? keyRefresh;
  final Widget? child;
  final Future Function()? onRefresh;

  const RefreshWidget({
    Key? key,
    this.keyRefresh,
    this.onRefresh,
   this.child,
  }) : super(key: key);

  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) =>buildAndroidList();
  // Platform.isAndroid ? buildAndroidList() : buildIOSList();

  Widget buildAndroidList() => RefreshIndicator(
    color: AppColors.amber,
    key: widget.keyRefresh,
    onRefresh: widget.onRefresh!,
    child: widget.child!,
  );

  // Widget buildIOSList() => CustomScrollView(
  //   physics: BouncingScrollPhysics(),
  //   slivers: [
  //     CupertinoSliverRefreshControl(onRefresh: widget.onRefresh),
  //     SliverToBoxAdapter(child: widget.child),
  //   ],
  // );
}