import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../../config/theme/my_fonts.dart';
import '../../../components/empty_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts'),
        centerTitle: true,
      ),
      body: Obx(() => controller.postList.isEmpty
          ? const EmptyWidget()
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: RawScrollbar(
                thumbColor: theme.primaryColor,
                radius: const Radius.circular(100),
                thickness: 5,
                interactive: true,
                child: ListView.separated(
                  itemCount: controller.postList.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  separatorBuilder: (_, __) => SizedBox(
                    height: 20.h,
                  ),
                  itemBuilder: (ctx, index) => Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    color: theme.canvasColor,
                    child: Center(
                      child: Text(
                        controller.postList[index].title ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MyFonts.headline6TextSize,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
    );
  }
}
