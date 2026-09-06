import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveNumExtension on num {
  double get width => ScreenUtil().setWidth(toDouble());

  double get height => ScreenUtil().setHeight(toDouble());

  double get sp => ScreenUtil().setSp(toDouble());

  SizedBox get widthBox => SizedBox(width: toDouble());

  SizedBox get heightBox => SizedBox(height: toDouble());
}
