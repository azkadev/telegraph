// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unnecessary_import

import "dart:convert";

import "package:http/http.dart";
import "package:general_lib/general_lib.dart";

/// DOCS: https://telegra.ph/api
class Telegraph {
  Uri telegraph_api = Uri.parse("https://api.telegra.ph");
  Telegraph();

  Future<Map> invoke({
    required String method,
    required Map parameters,
    String? path_api,
    String method_request = "get",
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    };
    Map<String, String?> queryParameters = {};

    if (method != "post") {
      parameters.forEach((key, value) {
        queryParameters[key] = value;
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
      response = await post(uri, body: json.encode(parameters), headers: headers);
    } else {
      response = await get(uri, headers: headers);
    }
    Map result = json.decode(response.body);
    if (result["ok"] != true) {
      result["@type"] = "error";
      return result;
    }
    if (result["result"] is Map) {
      result["result"]["@type"] = method.replaceAll(RegExp("^(create|get)", caseSensitive: false), "").toLowerCaseFirstData();
      return result["result"];
    }
    return result["result"];
  }

  /// Details: https://telegra.ph/api#createAccount
  Future<Map> createAccount({required String short_name, required String author_name, String? author_url}) async {
    Map parameters = {
      "short_name": short_name,
      "author_name": author_name,
    };

    if (author_url != null) {
      parameters["author_url"] = author_url;
    }
    Map result = await invoke(method: "createAccount", parameters: parameters);

    return result;
  }

  /// DETAILS: https://telegra.ph/api#editAccountInfo
  Future<Map> editAccountInfo({
    required String access_token,
    String? short_name,
    String? author_name,
    String? author_url,
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
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#getAccountInfo
  Future<Map> getAccountInfo({
    required String access_token,
    List<String>? fields,
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
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#revokeAccessToken
  Future<Map> revokeAccessToken({
    required String access_token,
  }) async {
    Map parameters = {
      "access_token": access_token,
    };

    Map result = await invoke(
      method: "revokeAccessToken",
      parameters: parameters,
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#createPage
  Future<Map> createPage({
    required String access_token,
    required String title,
    String? author_name,
    String? author_url,
    required String content,
    bool return_content = false,
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
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#editPage
  Future<Map> editPage({
    required String access_token,
    required String path,
    required String title,
    required String content,
    String? author_name,
    String? author_url,
    bool return_content = false,
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
    );

    return result;
  }

  /// DETAILS: https://telegra.ph/api#getPage
  Future<Map> getPage({
    required String path,
    bool return_content = false,
  }) async {
    Map parameters = {
      "return_content": return_content,
    };

    Map result = await invoke(
      method: "getPage",
      parameters: parameters,
      path_api: path,
    );
    return result;
  }

  /// DETAILS: https://telegra.ph/api#getPageList
  Future<Map> getPageList({
    required String access_token,
    int offset = 0,
    int limit = 50,
  }) async {
    Map parameters = {
      "access_token": access_token,
      "offset": offset,
      "limit": limit,
    };

    Map result = await invoke(
      method: "getPageList",
      parameters: parameters,
      // path_api: path,
    );
    return result;
  }

  /// DETAILS: https://telegra.ph/api#getViews
  Future<Map> getViews({required String path, required int year, required int month, required int day, int? hour}) async {
    Map parameters = {
      "year": year,
      "month": month,
      "day": day,
    };

    if (hour != null) {
      parameters["hour"] = hour;
    }

    Map result = await invoke(
      method: "getViews",
      parameters: parameters,
      path_api: path,
    );
    return result;
  }
}
