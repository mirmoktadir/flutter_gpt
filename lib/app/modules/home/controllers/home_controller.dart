import 'package:get/get.dart';
import 'package:getx_standard/app/service/api_urls.dart';
import 'package:getx_standard/app/service/base_controller.dart';
import 'package:getx_standard/app/service/dio_client.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController with BaseController {
  final String apiKey = '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';
  final sendMessageKey = GlobalKey<FormState>();
  var botMessage = "";
  sendMessage(String? message) async {
    var request = {
      "model": "text-davinci-003",
      "prompt": message,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    };
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    var response = await DioClient()
        .post(
          url: ApiUrl.baseUrl,
          header: header,
          body: request,
        )
        .catchError(handleError);
    if (response == null) return;
    sendMessageKey.currentState!.save();
    botMessage = response["choices"][0]["text"];
  }
}
