import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:news_application/model/source_response.dart';

import '../model/article_response.dart';

abstract class ApiManager {
  static const String defaultErrorMessage = "something went wrong please try again later";
  static const String baseUrl = "https://newsapi.org";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";
  static const String apiKey = "beee18fd98424b49ac6760f2fe103342";

  static Future<SourceResponse> loadTabsList(String categoryId) async {
    try {
      ///first: should i know type of request (Get or Post)
      Uri url = Uri.parse(
          "$baseUrl$sourcesEndPoint?apiKey=$apiKey&category=$categoryId");
      Response response = await get(url);
      SourceResponse sourceResponse =
          SourceResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {

        return sourceResponse;
      } else {
        throw 'Something went wrong please try again later';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<ArticlesResponse> loadArticlesList(String sourceId) async {
    try{
      Uri url = Uri.parse("$baseUrl$articlesEndPoint?apiKey=$apiKey&sources=$sourceId");
      Response apiResponse = await get(url);
      ArticlesResponse articleResponse = ArticlesResponse.fromJson(jsonDecode(apiResponse.body));
      if(apiResponse.statusCode >= 200 && apiResponse.statusCode <300) {
        return articleResponse;
      }else {
        throw articleResponse.message ?? defaultErrorMessage;
      }
    }catch(e) {
      rethrow;
    }
  }
}
