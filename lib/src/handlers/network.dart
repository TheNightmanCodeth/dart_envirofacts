//  network.dart
//
//  This file is a part of the dart_envirofacts project.
//
//  dart_envirofacts is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This porogram is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
///  Created by Joe Diragi on 3/19/19.
///  Copyright © 2019 Joe Diragi. All rights reserved.
import 'dart:core';

/// Simplifies API calls to the envirofacts site
class Network {
  static String URL = "https://iaspub.epa.gov/enviro/efservice";

  /// Makes a url for certain endpoints and values. 
  /// 
  /// Throws an [ArgumentError] if the [filterOperator] argument is 
  /// provided without any filter to apply. The [endpoint] can be any one of
  /// the endpoints described [here](https://www.epa.gov/enviro/envirofacts-data-service-api#metadata). The [columnName] is only provided if only
  /// a single column is required OR a filter is needed. It can be a string, or 
  /// a list of strings. The [filterOperator] is one of 
  /// {=, !=, <, >, BEGINNING, CONTAINING}, and compares the [columnName] to the
  /// [filterValue]. The url returns either the first 10,000 results, or the rows 
  /// between the two integers provided by [rowsToShow]. The response will be in
  /// `XML` format by default, but can be any of: {XML, CSV, EXCEL, JSON}. If
  /// it is provided, [count] will make the response contain only the amount of 
  /// results that would be returned if the query were to be made.
  static make_url(var endpoint, {var columnName, var filterOperator, 
                  var filterValue, var rowsToShow, var format, bool count}) {
    var appropriateFormats = ["xml", "json", "csv", "excel"];
    var url = "$URL/$endpoint/";
    if (columnName != null) {
      if (filterOperator == null || filterValue == null)
        throw new ArgumentError("columnName provided with no filter or value");
      url += "$columnName/$filterOperator/$filterValue/";
    } else if (filterOperator != null || filterValue != null)
        throw new ArgumentError("filter provided with no column name");
    if (rowsToShow != null) {
      if (rowsToShow is List && rowsToShow.length == 2) {
        url += "${rowsToShow[0]}:${rowsToShow[1]}/";
      } else throw new ArgumentError("rowsToShow must be a list of length 2");
    }
    if (format != null) {
      if (appropriateFormats.contains(format.toString().toLowerCase())) {
        url += "$format/";
      } else throw ArgumentError("$format is not a valid format");
    }
    if (count != null && count) {
      url += "COUNT/";
    }
    return url;
  }

  
}