import 'package:dio/dio.dart';
import 'package:giphyclient/api/models/trending/trending_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.giphy.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/v1/gifs/trending")
  Future<TrendingResponse> getTrendings(
    @Query('api_key') String apiKey,
    @Query('offset') int offset,
  );

  @GET("/v1/gifs/search")
  Future<TrendingResponse> getSearchResult(
      @Query('api_key') String apiKey,
      @Query('q') String query,
      @Query('offset') int offset,
      );
}
