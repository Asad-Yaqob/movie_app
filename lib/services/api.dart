import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesApiService {
  
  static Future loadData(pageNo) async {
    try {
      // Example #1
      final url = Uri.https(
          'www.episodate.com', '/api/most-popular', {'page': '$pageNo'});
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong');
      }

      if (response.body == 'null') {
        return {};
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }

      return {};
    } catch (e) {
      print(e);
    }

    // Example # 2
    // final url = Uri.parse('https://www.episodate.com/api/most-popular?page=1');
    // final request = http.Request('get', url);
    // http.StreamedResponse response = await request.send();
  }

  static Future searchMovie(movieName) async {
    final url =
        Uri.https('www.episodate.com', '/api/search', {'q': '$movieName'});
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception("Something went wrong");
    }

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      return result;
    }

    return;
  }

  static getMovieDetail(movieName) async {
    try {
      final url = Uri.https(
          'www.episodate.com', '/api/show-details', {'q': '$movieName'});
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }
}
