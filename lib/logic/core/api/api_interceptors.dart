import 'package:dio/dio.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/end_ponits.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.token] =
        CacheHelper().getData(key: ApiKey.token) != null
            ? '${CacheHelper().getData(key: ApiKey.token)}'
            : null;
            options.headers[ApiKey.idgovernrate] =
        CacheHelper().getData(key: ApiKey.idgovernrate) != null
            ? '${CacheHelper().getData(key: ApiKey.idgovernrate)}'
            : null;
    super.onRequest(options, handler);
  }
}



// import 'package:dio/dio.dart';
// import 'package:kemet/logic/cache/cache_helper.dart';
// import 'package:kemet/logic/core/api/end_ponits.dart';

// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     final String? token = CacheHelper().getData(key: ApiKey.token);
//     options.headers[ApiKey.token] = token != null ? token : null;
    
//     // Modify the URL to match the base URL from EndPoint
//     if (options.baseUrl == null || !options.baseUrl!.startsWith(EndPoint.baseUrl)) {
//       options.baseUrl = EndPoint.baseUrl;
//     }
    
//     super.onRequest(options, handler);
//   }
// }
