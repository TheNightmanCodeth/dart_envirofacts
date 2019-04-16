import 'dart:core';

import 'package:http/http.dart' as http;

import 'request_filter.dart';

/// Simplifies API calls to the envirofacts site
class Network {
  /// The base API url
  String baseUrl = "https://iaspub.epa.gov/enviro/efservice";

  /// Creates a [Network] instance with the provided [endpoint] and optional
  /// [RequestFilter].
  Network(String endpoint, RequestFilter filter) {
    // TBI
  }

  /// Makes a url for certain endpoints and values. 
  /// 
  /// Throws an [ArgumentError] if the [filterOperator] argument is 
  /// provided without any filter to apply. The [endpoint] can be any one of
  /// the endpoints described [here](https://www.epa.gov/enviro/envirofacts-data-service-api#metadata). The [columnName] is only provided if only
  /// a single column is required OR a filter is needed. It can be a string, or 
  /// a list of strings. The [filterOperator] is one of 
  /// {=, !=, <, >, BEGINNING, CONTAINING}, and compares the [columnName] to the
  /// [filterValue]. The url returns either the first 10,000 results, or the 
  /// rows between the two integers provided by [rowsToShow]. The response will
  /// be in `XML` format by default, but can be any of: {XML, CSV, EXCEL, JSON}.
  /// If it is provided, [count] will make the response contain only the amount 
  /// of results that would be returned if the query were to be made.
  String makeUrl(String endpoint, {String columnName, 
      String filterOperator, String filterValue, List rowsToShow, String format,
      bool count}) {
    var appropriateFormats = ["xml", "json", "csv", "excel"];
    var url = "$baseUrl/$endpoint/";
    if (columnName != null) {
      if (filterOperator == null || filterValue == null) {
        throw ArgumentError("columnName provided with no filter or value");
      }
      url += "$columnName/$filterOperator/$filterValue/";
    } else if (filterOperator != null || filterValue != null) {
        throw ArgumentError("filter provided with no column name");
    }
    if (rowsToShow != null) {
      if (rowsToShow is List && rowsToShow.length == 2) {
        url += "${rowsToShow[0]}:${rowsToShow[1]}/";
      } else {
        throw ArgumentError("rowsToShow must be a list of length 2");
      }
    }
    if (format != null) {
      if (appropriateFormats.contains(format.toString().toLowerCase())) {
        url += "$format/";
      } else {
        throw ArgumentError("$format is not a valid format");
      }
    }
    if (count != null && count) {
      url += "COUNT/";
    }
    return url;
  }

  /// Returns the response from the provided [endpoint]
  Future<String> getData(String endpoint) async {
    var response = await http.get(endpoint);
    var body =response.body;
    return body;
  }
}