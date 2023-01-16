import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GPT'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 8.h),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        color: Colors.deepOrange,
                      );
                    },
                    separatorBuilder: (context, _) {
                      return SizedBox(height: 5.h);
                    },
                    itemCount: 10),
              ),
              Form(
                key: controller.sendMessageKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      //message box
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            controller: textEditingController,
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            onSaved: (value) {
                              textEditingController.text = value!;
                            },
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 15,
                              ),
                              hintText: "send a message",
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: theme.primaryColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: theme.primaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: theme.primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // send button
                      SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            style: theme.elevatedButtonTheme.style,
                            onPressed: () async {
                              await controller
                                  .sendMessage(textEditingController.text);
                              textEditingController.clear();
                            },
                            child: const Icon(IconlyLight.send),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
