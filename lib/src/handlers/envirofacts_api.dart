import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:dart_json/dart_json.dart';

/// keys for [validEndpoints]
enum ENDPOINT {
  /// Active SEMS sites
  semsActiveSites,
  /// Archived SEMS sites
  semsArchivedSites
}

/// A list of valid and implemented API endpoint values
const Map<ENDPOINT, String> validEndpoints = {
  // SEMS endpoints
  ENDPOINT.semsActiveSites: "SEMS_ACTIVE_SITES",
  ENDPOINT.semsArchivedSites: "SEMS_ARCHIVED_SITES"
};

/// Simplifies API calls to the envirofacts site
class EnvirofactsAPI {
  /// The base url for the epa's api
  static String baseUrl = "https://iaspub.epa.gov/enviro/efservice";
  /// The current url for this instance
  String url;
  /// The results from the last api request
  List latestResults;
  /// An optional endpoint for this instance
  ENDPOINT endpoint;
  /// Creates an [EnvirofactsAPI] instance for the [endpoint].
  EnvirofactsAPI.withEndpoint(this.endpoint);
  /// Creates an [EnvirofactsAPI] instance for the [url].
  EnvirofactsAPI.withURL(this.url);

  /// Returns a list of replies from the network
  /// 
  /// [apiEndpoint] - Optional endpoint override for this instance of the API
  /// [apiURL] - Optional full url override for this instance of the API
  /// returns the first [resultCount] entries from the remote
  Future<List<T>> requestResults<T>({ENDPOINT apiEndpoint, String apiURL, 
    int resultCount}) async {
    if (endpoint == null && url == null) {
      if (apiEndpoint == null && apiURL == null) {
        throw ArgumentError(
          "requestResults called when no endpoint or url is provided");
      } else if (apiURL != null) {
        if (!apiURL.contains("json")) {
          throw ArgumentError("url must contain json type argument");
        }
        url = apiURL;
      } else {
        endpoint = apiEndpoint;
      }
    } else if (apiURL == null) {
      var count = 9;
      if (resultCount != null) {
        count = resultCount;
      }
      url = "$baseUrl/${validEndpoints[endpoint]}/ROWS/0:$count/json";
    }
    var request = await http.get(url);
    return Json.deserialize<List<T>>(request.body);
  }
}
