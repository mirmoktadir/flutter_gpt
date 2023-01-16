import 'package:get/get.dart';
import 'package:getx_standard/app/service/api_urls.dart';
import 'package:getx_standard/app/service/base_controller.dart';
import 'package:getx_standard/app/service/dio_client.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController with BaseController {
  String apiKey = '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';
  final sendMessageKey = GlobalKey<FormState>();
  sendMessage(String? message) async {
    var request = {
      "model": "text-davinci-003",
      "prompt": "$message",
      "max_tokens": 7,
      "temperature": 0,
      "top_p": 1,
      "n": 1,
      "stream": false,
      "logprobs": null,
      "stop": [" Human:", " AI:"]
    };
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    showLoading();
    var response = await DioClient()
        .post(
          url: ApiUrl.baseUrl,
          header: header,
          body: request,
        )
        .catchError(handleError);
    if (response == null) return;
    sendMessageKey.currentState!.save();
    print(response["choices"][0]["text"]);
    hideLoading();
  }
}
