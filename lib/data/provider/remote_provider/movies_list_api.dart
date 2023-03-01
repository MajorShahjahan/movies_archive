import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies_archive/utilities/constants/constants.dart';
import 'package:movies_archive/utilities/exception/exception_handler.dart';

class MoviesListApi {
  static Future<http.Response> searchMovies(String query) async {
    final http.Response response;
    try {
      response = await http.get(Uri.parse('$baseUrl/?s=$query&apikey=$apiKey'));
    } on TimeoutException {
      throw TimeoutException("Timed out");
    } on SocketException {
      throw NoInternetException("No Internet");
    } on HttpException {
      throw NoServiceFoundException("No Service Found");
    } catch (e) {
      throw UnknownException(e.toString());
    }
    return response;
  }
}
