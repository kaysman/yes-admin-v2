import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:admin_v2/Data/models/credentials.dart';
import 'package:collection/collection.dart' show IterableExtension;
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/io_client.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

import '../models/error_log.dart';
import '../models/response.dart';
import 'app.service.dart';
import 'local_storage.service.dart';

const baseUrl = 'http://192.168.1.33:3333';

class ApiClient {
  static Client? http;
  static PackageInfo? packageInfo;
  static Future? refreshing;

  static interceptorClient() {
    return InterceptedClient.build(
      interceptors: [],
      retryPolicy: ExpiredTokenRetryPolicy(),
      requestTimeout: const Duration(seconds: 30),
      client: Client(),
    );
  }

  // // resets client connection
  // static reset() {
  //   AppService.httpRequests!.clear();
  //   http!.close();
  //   http = interceptorClient();
  // }

  // lazy-load client
  ApiClient._setInstance() {
    http = http ?? interceptorClient();
    if (packageInfo == null) {
      PackageInfo.fromPlatform().then((PackageInfo info) {
        ApiClient.packageInfo = info;
      });
    }
  }
  static final ApiClient instance = ApiClient._setInstance();

  ///
  /// [IN-MEMORY CREDENTIALS]
  ///

  static Credentials? _credentials;
  static Future<Credentials?> get credentials async {
    if (_credentials == null) {
      var disk = await LocalStorage.instance;
      setCredentials(disk?.credentials);
      if (_credentials == null) AppService.onAuthError();
    }
    return _credentials;
  }

  static setCredentials(Credentials? cred) {
    _credentials = cred;
  }

  ///
  /// [Headers, ApiResponse]
  ///

  Future<ApiResponse> put(Uri uri,
      {Map<String, String>? headers,
      dynamic data,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'PUT', uri, data: data, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> post(Uri uri,
      {Map<String, String>? headers,
      dynamic data,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'POST', uri, data: data, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> get(Uri uri,
      {dynamic data,
      Map<String, String>? headers,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'GET', uri, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> delete(Uri uri,
      {Map<String, String>? headers,
      int apiVersion = 1,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'DELETE', uri, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future download(String url, String udid, String filename) async {
    var location = (Platform.isAndroid)
        ? await (getExternalStorageDirectory() as FutureOr<Directory>)
        : await getApplicationDocumentsDirectory();
    try {
      final savedDir = Directory('${location.path}/$filename');
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        await savedDir.create();
      }

      var cred = await (credentials as FutureOr<Credentials>);
      // await FlutterDownloader.enqueue(
      //   // TODO:
      //   headers: {
      //     "Authorization": "Basecamp ${cred.accessToken}",
      //     "x-client-type": "mobile",
      //     "udid": udid
      //   },
      //   url: url,
      //   fileName: filename,
      //   savedDir: savedDir.path,
      //   showNotification: true,
      //   openFileFromNotification: true,
      //   saveInPublicStorage: true,
      // );
    } catch (e) {
      print('exception:' + e.toString());
    }
  }

  ///
  /// [RETRY]
  ///
  Future<ApiResponse> sendWithRetry(ClientRequest req,
      {int maxRetries = 1}) async {
    AppService.httpRequests?.add(req.uri.path);

    DateTime start = DateTime.now();
    int retries = 0;

    print('send it');
    try {
      final response = await req.send();

      var data = ApiResponse.fromJson(jsonDecode(response.body));
      if (data != null && data.success == true) {
        AppService.httpRequests?.remove(req.uri.path);
        return data;
      } else {
        // logAttempt(response, retries);
        throw HttpException(
          '${response.statusCode} | ${response.reasonPhrase} | ${response.body}',
        );
      }
    } on SocketException catch (e) {
      print('No Internet connection 😑');
      handleException(req, 'SocketException', e.toString(), retries);
    } on HttpException catch (e) {
      print("Couldn't find the post 😱");
      handleException(req, 'HttpException', e.toString(), retries);
    } on FormatException catch (e) {
      print("Bad response format 👎");
      handleException(req, 'FormatException', e.toString(), retries);
    } on HandshakeException catch (e) {
      print("Bad handshake 👎");
      handleException(req, 'HandshakeException', e.toString(), retries);
    } on ClientException catch (e) {
      print("Client was reset");
      AppService.httpRequests?.remove(req.uri.path);
      throw ClientException("Client was reset");
    } catch (_) {
      print("👎👎👎👎👎👎");
      print(_);
      handleException(req, 'Exception', _.toString(), retries);
    } finally {
      retries++;
      await Future.delayed(
          Duration(milliseconds: 100 * (pow(2, retries) as int)));
    }

    AppService.httpRequests?.remove(req.uri.path);
    throw TimeoutException("Client timeout");
  }

  handleException(ClientRequest req, String type, String e, retries) {
    print(e);
    var details = jsonEncode({
      "retry": retries,
      "version":
          'Version - ${packageInfo?.version ?? '??'} / Build - ${packageInfo?.buildNumber ?? '??'}',
      "error": e,
    });

    logAttempt(req, type, details);
  }

  logAttempt(ClientRequest req, String type, String details) {
    if (req.uri.path == '/api/v1/logging/errors') return;

    (LocalStorage.instance).then((store) => store!.enqueueErrorLog(ErrorLog(
          errorDate: DateTime.now().toUtc(),
          category: 'MOBILE',
          location: '${req.method} | ${req.uri.path}',
          userId: AppService.currentUserID.value,
          params: req.uri.query,
          message: type,
          details: details,
        )));
  }
}

// single retry for authorization errors
class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    try {
      // TODO: fix 500 error thrown for an unauthorized request
      var data = response.body!.isEmpty
          ? null
          : ApiResponse.fromJson(jsonDecode(response.body!));

      // refresh conditions
      if (response.statusCode == 401 ||
          response.statusCode == 403 ||
          (data != null &&
              data.errors!
                  .where((err) => err.description == "Unauthorized")
                  .isNotEmpty)) {
        if (ApiClient.refreshing == null) {
          // ApiClient.refreshing = AuthService.refreshCredentials();
        }
        await ApiClient.refreshing;
        ApiClient.refreshing = null;
        return true;
      }
      return false;
    } catch (_) {
      // auth error called by auth service
      return false;
    }
  }
}

// add credentials to non-anonymous headers
class BearerTokenApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    var anonymousKey =
        data.headers.keys.firstWhereOrNull((element) => element == 'anonymous');

    var anonymousKeyIndex;
    if (anonymousKey != null)
      anonymousKeyIndex = data.headers.keys.toList().indexOf(anonymousKey);

    if (anonymousKeyIndex == null ||
        (data.headers.values.elementAt(anonymousKeyIndex) == "false")) {
      try {
        final cred = (await ApiClient.credentials);
        if (cred != null &&
            cred.accessToken != null &&
            cred.accessToken!.isNotEmpty) {
          data.headers.addAll({
            "Authorization": 'Basecamp ${cred.accessToken}',
            "Date": DateTime.now().toUtc().toString(),
          });
        } else {
          AppService.onAuthError();
        }
      } catch (e) {
        print(e);
      }
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

class ClientRequest {
  final Client client;
  final String method;
  final Uri uri;
  final Map<String, String>? headers;
  final dynamic data;

  ClientRequest(
    this.client,
    this.method,
    this.uri, {
    this.headers,
    this.data,
  });

  Future<Response> send() async {
    switch (method) {
      case 'GET':
        return await client.get(uri, headers: headers);
      case 'POST':
        return await client.post(uri, headers: headers, body: data);
      case 'PUT':
        return await client.put(uri, headers: headers, body: data);
      case 'DELETE':
        return await client.delete(uri, headers: headers);
      default:
        return await client.get(uri, headers: headers);
    }
  }
}

// class LoggingInterceptor implements InterceptorContract {
//   @override
//   Future<RequestData> interceptRequest({RequestData data}) async {
//     AppService.httpRequests.add(data.url);
//     return data;
//   }

//   @override
//   Future<ResponseData> interceptResponse({ResponseData data}) async {
//     AppService.httpRequests.remove(data.url);
//     return data;
//   }
// }

// single retry for authorization errors
// class ExpiredTokenRetryPolicy extends RetryPolicy {

//   @override
//   Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
//     try {
//       // refresh conditions
//       if (response.statusCode == 401) {
//         ApiClient.setCredentials(await AuthService.refreshCredentials());
//         await logAttempt(response);
//         return await retryAfterDelay();
//       }

//       var res = ApiResponse.fromJson(jsonDecode(response.body));

//       // refresh conditions
//       if (res != null &&
//           res.errors != null &&
//           res.errors.where((e) => e.description == "Unauthorized").isNotEmpty) {
//         await refreshCredentials();
//         await logAttempt(response);
//         return await retryAfterDelay();
//       }

//       // general failure
//       if (res != null) {
//         if (res.success) retries = 0;
//         return !res.success;
//       } else {
//         await logAttempt(response);
//         return await retryAfterDelay();
//       }
//     } catch (_) {
//       // parsing failure
//       await logAttempt(response);
//       return await retryAfterDelay();
//     }
//   }

//   Future<bool> retryAfterDelay() =>
//       Future.delayed(Duration(seconds: 1), () => true);

//   logAttempt(ResponseData response) async {
//     var httpResponse = response.toHttpResponse();
//     if (httpResponse.request.url.path == '/api/v1/logging/errors') return;

//     var start = DateTime.parse(response.request.headers['Date']);
//     var duration = start.difference(DateTime.now()).abs();

//     var details = jsonEncode({
//       "retry": retries,
//       "statusCode": response.statusCode,
//       "duration(ms)": duration.inMilliseconds,
//       "message": httpResponse.reasonPhrase,
//       "response": httpResponse.body == null
//           ? 'NO RESPONSE'
//           : (httpResponse.body.isEmpty)
//               ? 'EMPTY RESPONSE'
//               : httpResponse.body,
//     });
//     (await LocalStorage.instance).enqueueErrorLog(ErrorLog(
//         errorDate: DateTime.now().toUtc(),
//         category: 'MOBILE',
//         location: '${response.method} | ${httpResponse.request.url.path}',
//         userId: AppService.currentUserID.value,
//         teamId: AppService.currentTeamID.value,
//         params: httpResponse.request.url.query,
//         message: httpResponse?.reasonPhrase ?? 'NO RESPONSE',
//         details: details));

//     if (retries == 3) {
//       retries = 0;
//     } else {
//       retries += 1;
//     }
//   }
// }
