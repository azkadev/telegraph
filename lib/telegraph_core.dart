// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import, unnecessary_brace_in_string_interps

import "dart:async";
import "dart:convert";
import "dart:io";

import "package:http/http.dart";
import "package:general_lib/general_lib.dart";
import "package:http_parser/http_parser.dart";
import "package:telegraph/telegraph_file.dart";

/// DOCS: https://telegra.ph/api
class Telegraph {
  Uri telegraph_api = Uri.parse("https://api.telegra.ph");
  late Client http_client;
  Telegraph({
    Client? httpClient,
  }) {
    if (httpClient != null) {
      http_client = httpClient;
    } else {
      http_client = Client();
    }
  }

  Future<Map> invoke({
    required String method,
    required Map parameters,
    String? path_api,
    String method_request = "get",
    Client? httpClient,
  }) async {
    httpClient ??= http_client;
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    };
    Map<String, dynamic> queryParameters = {};

    if (method != "post") {
      parameters.forEach((key, value) {
        if (value == null) {
          return;
        }
        if (value is String == false) {
          if (value is Map || value is List) {
            queryParameters[key] = json.encode(value);
          } else {
            queryParameters[key] = value.toString();
          }
        } else {
          queryParameters[key] = value;
        }
      });
    }

    List<String> pathSegments = [
      method,
    ];

    if (path_api != null) {
      pathSegments.add(path_api);
    }

    Uri uri = telegraph_api.replace(
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
    late Response response;
    if (method == "post") {
      response = await httpClient.post(uri, body: json.encode(parameters), headers: headers);
    } else {
      response = await httpClient.get(uri, headers: headers);
    }
    Map result = () {
      try {
        return json.decode(response.body);
      } catch (e) {
        // print(response.body);
        return {"error_data": response.body};
      }
    }();
    if (result["ok"] != true) {
      result["@type"] = "error";
      return result;
    }
    if (result["result"] is Map) {
      Map new_data = {
        "@type": method.replaceAll(RegExp("^(create|get|copy)", caseSensitive: false), "").toLowerCaseFirstData(),
        ...(result["result"] as Map),
      };

      return new_data;
    }
    return {
      "@type": "ok",
      ...result,
    };
  }

  /// Details: https://telegra.ph/api#createAccount
  Future<Map> createAccount({
    required String short_name,
    required String author_name,
    String? author_url,
    Client? httpClient,
  }) async {
    Map parameters = {
      "short_name": short_name,
      "author_name": author_name,
    };

    if (author_url != null) {
      parameters["author_url"] = author_url;
    }
    Map result = await invoke(
      method: "createAccount",
      parameters: parameters,
      httpClient: httpClient,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#editAccountInfo
  Future<Map> editAccountInfo({
    required String access_token,
    String? short_name,
    String? author_name,
    String? author_url,
    Client? httpClient,
  }) async {
    Map parameters = {
      "access_token": access_token,
    };

    if (short_name != null) {
      parameters["short_name"] = short_name;
    }
    if (author_name != null) {
      parameters["author_name"] = author_name;
    }

    if (author_url != null) {
      parameters["author_url"] = author_url;
    }
    Map result = await invoke(
      method: "editAccountInfo",
      parameters: parameters,
      httpClient: httpClient,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#getAccountInfo
  Future<Map> getAccountInfo({
    required String access_token,
    List<String>? fields,
    Client? httpClient,
  }) async {
    Map parameters = {
      "access_token": access_token,
    };

    if (fields != null) {
      parameters["fields"] = fields;
    }
    Map result = await invoke(
      method: "getAccountInfo",
      parameters: parameters,
      httpClient: httpClient,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#revokeAccessToken
  Future<Map> revokeAccessToken({
    required String access_token,
    Client? httpClient,
  }) async {
    Map parameters = {
      "access_token": access_token,
    };

    Map result = await invoke(
      method: "revokeAccessToken",
      parameters: parameters,
      httpClient: httpClient,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#createPage
  Future<Map> createPage({
    required String access_token,
    required String title,
    String? author_name,
    String? author_url,
    required List content,
    bool return_content = true,
    Client? httpClient,
  }) async {
    Map parameters = {
      "access_token": access_token,
      "title": title,
      "content": content,
      "return_content": return_content,
    };

    if (author_name != null) {
      parameters["author_name"] = author_name;
    }
    if (author_url != null) {
      parameters["author_url"] = author_url;
    }

    Map result = await invoke(
      method: "createPage",
      parameters: parameters,
      method_request: "post",
      httpClient: httpClient,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#editPage
  Future<Map> editPage({
    required String access_token,
    required String path,
    required String title,
    required List content,
    String? author_name,
    String? author_url,
    bool return_content = true,
    Client? httpClient,
  }) async {
    Map parameters = {
      "access_token": access_token,
      "title": title,
      "content": content,
      "return_content": return_content,
    };

    if (author_name != null) {
      parameters["author_name"] = author_name;
    }
    if (author_url != null) {
      parameters["author_url"] = author_url;
    }

    Map result = await invoke(
      method: "editPage",
      parameters: parameters,
      path_api: path,
      method_request: "post",
      httpClient: httpClient,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#getPage
  Future<Map> getPage({
    required String path,
    bool return_content = true,
    Client? httpClient,
  }) async {
    Map parameters = {
      "return_content": return_content,
    };

    Map result = await invoke(
      method: "getPage",
      parameters: parameters,
      path_api: path,
      httpClient: httpClient,
    );
    return result;
  }

  /// DETAILS: https://telegra.ph/api#getPageList
  Future<Map> getPageList({
    required String access_token,
    int offset = 0,
    int limit = 50,
    Client? httpClient,
  }) async {
    Map parameters = {
      "access_token": access_token,
      "offset": offset,
      "limit": limit,
    };

    Map result = await invoke(
      method: "getPageList",
      parameters: parameters,
      httpClient: httpClient,
      // path_api: path,
    );
    return result;
  }

  /// DETAILS: https://telegra.ph/api
  Future<Map> copyPage({
    required String access_token,
    required String path,
    String? title,
    String? author_name,
    String? author_url,
    bool return_content = true,
    Client? httpClient,
  }) async {
    Map page_data = await getPage(path: path, return_content: true);
    return await createPage(
      access_token: access_token,
      title: title ?? page_data["title"] ?? DateTime.now().toString(),
      author_name: author_name,
      author_url: author_url,
      content: page_data["content"],
      return_content: return_content,
    );
  }

  /// DETAILS: https://telegra.ph/api#getViews
  Future<Map> getViews({
    required String path,
    int? year,
    int? month,
    int? day,
    int? hour,
    Client? httpClient,
  }) async {
    Map parameters = {
      "year": year,
      "month": month,
      "day": day,
      "hour": hour,
    };

    Map result = await invoke(
      method: "getViews",
      parameters: parameters,
      path_api: path,
      httpClient: httpClient,
    );
    return result;
  }

  Future<Map> upload({
    required List<TelegraphFileData> telegraphFileDatas,
    // required Uint8List blob,
    Client? httpClient,
    bool isThrowOnError = true,
    void Function(int bytesCount, int totalBytes)? onUploadProgress,
  }) async {
    Uri url = Uri.parse("https://telegra.ph/upload");
    HttpClient httpClientForm = HttpClient();
    HttpClientRequest request = await httpClientForm.postUrl(url);
    MultipartRequest form = MultipartRequest("post", url);

    for (var i = 0; i < telegraphFileDatas.length; i++) {
      TelegraphFileData telegraphFileData = telegraphFileDatas[i]; 

      MultipartFile file = MultipartFile.fromBytes(
        "file_${i}",
        telegraphFileData.bytes,
        filename: telegraphFileData.name,
        contentType: MediaType.parse(telegraphFileData.mime),
      );
      form.files.add(file);
    }

    ByteStream msStream = form.finalize();
    int totalByteLength = form.contentLength;
    request.contentLength = totalByteLength;
    request.headers.set(
      HttpHeaders.contentTypeHeader,
      form.headers[HttpHeaders.contentTypeHeader]!,
    );
    int byteCount = 0;
    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);
          byteCount += data.length;
          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
        },
      ),
    );
    await request.addStream(streamUpload);
    HttpClientResponse httpResponse = await request.close();
    var statusCode = httpResponse.statusCode;
    Completer<String> completer = Completer<String>();
    StringBuffer contents = StringBuffer();
    httpResponse.transform(utf8.decoder).listen(
      (String data) {
        contents.write(data);
      },
      onDone: () => completer.complete(contents.toString()),
    );
    dynamic bodys = json.decode(await completer.future);
    if (statusCode == 200) {
      if (bodys is List) {
        List<Map> files = [];
        for (var i = 0; i < bodys.length; i++) {
          dynamic body = bodys[i];
          if (body is Map) {
            files.add({"url": "https://telegra.ph${body["src"]}"});
          }
        }

        return {
          "@type": "files",
          "total_count": files.length,
          "files": files,
        };
      }
      return {
        "@type": "error",
        ...bodys,
      };
      // return `https://telegra.ph${json[0].src}`;
      // return body;
    } else {
      if (isThrowOnError) {
        throw bodys;
      } else {
        return bodys;
      }
    }
  }
}
