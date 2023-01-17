import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../controllers/home_controller.dart';
import '../model/chat_message.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();

  final messages = RxList<ChatMessage>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GPT'),
        centerTitle: true,
      ),
      body: Obx(() => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // chat list
                  Expanded(child: chatSection(theme)),
                  Form(
                    key: controller.sendMessageKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          //input box
                          inputMessage(theme),
                          SizedBox(width: 8.w),

                          // send button
                          sendMessage(theme),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  /// chat list
  Widget chatSection(ThemeData theme) {
    return ListView.separated(
        reverse: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 8.h),
        itemBuilder: (context, index) {
          return chatBox(theme, index, context);
        },
        separatorBuilder: (context, _) {
          return SizedBox(height: 5.h);
        },
        itemCount: messages.length);
  }

  Widget chatBox(ThemeData theme, int index, BuildContext context) {
    return Container(
      color: ChatMessageType == ChatMessageType.bot
          ? theme.primaryColor
          : Colors.lightBlue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChatMessageType == ChatMessageType.bot
              ? Container(
                  color: Colors.red,
                  height: 50,
                  width: 50,
                )
              : Container(
                  color: Colors.green,
                  height: 50,
                  width: 50,
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    messages[index].text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// message type box
  Widget inputMessage(ThemeData theme) {
    return Expanded(
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
    );
  }

  /// sending button
  Widget sendMessage(ThemeData theme) {
    return SizedBox(
        height: 50.h,
        child: ElevatedButton(
          style: theme.elevatedButtonTheme.style,
          onPressed: () async {
            await controller.sendMessage(textEditingController.text);

            messages.add(ChatMessage(
                text: textEditingController.text,
                chatMessageType: ChatMessageType.user));
            textEditingController.clear();
            messages.add(ChatMessage(
                text: controller.botMessage,
                chatMessageType: ChatMessageType.bot));
          },
          child: const Icon(IconlyLight.send),
        ));
  }
}
