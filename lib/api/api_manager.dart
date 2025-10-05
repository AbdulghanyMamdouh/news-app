import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/model/source_response/news_response.dart';
import 'package:news_app/model/source_response/source_response.dart';
// 4cf1f66a6cc74cd5ad322a49cc3ddbbe
// GET https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY

class ApiManager {
  static int pageSize = 1;
  static Future<SourceResponse?> getSources(String categoryId) async {
    // 4cf1f66a6cc74cd5ad322a49cc3ddbbe
// GET https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY

    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.sourceEndpoint, {
      'apiKey': '4cf1f66a6cc74cd5ad322a49cc3ddbbe',
      'category': categoryId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    // https: //newsapi.org/v2/everything?q=bitcoin&apiKey=4cf1f66a6cc74cd5ad322a49cc3ddbbe
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.newsEndpoint, {
      'sources': sourceId,
      'apiKey': '4cf1f66a6cc74cd5ad322a49cc3ddbbe',
      'page': '$pageSize',
      'pageSize': '10',
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsBySearch({
    required String searchArticle,
  }) async {
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.newsEndpoint, {
      "apiKey": '4cf1f66a6cc74cd5ad322a49cc3ddbbe',
      "q": searchArticle,
    });

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
