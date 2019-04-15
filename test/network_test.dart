import 'package:dart_envirofacts/envirofacts.dart';
import 'package:test/test.dart';

void main() async {
  group('make_url', () {
    test('returns a valid URL from table', () {
      var x = "${Network.URL}/SEMS_ACTIVE_SITES/";
      expect(Network.make_url("SEMS_ACTIVE_SITES"), equalsIgnoringCase(x));
    });
    test('returns a valid URL from table, columnSort', () {
      var x = "${Network.URL}/TABLE/COL/=/COL/";
      expect(Network.make_url(
        "TABLE",
        columnName:"COL",
        filterOperator: "=",
        filterValue: "COL"
      ), equalsIgnoringCase(x));
    });
    test('returns a valid URL for json format', () {
      var x = "${Network.URL}/ENDPOINT/json";
      expect(Network.make_url("ENDPOINT", format: "JSON"), equalsIgnoringCase(x));
    });
    test('returns a valid URL for rowsToShow', () {
      var x = "${Network.URL}/E/100:110/";
      expect(Network.make_url("E", rowsToShow: [100, 110]), equalsIgnoringCase(x));
    });
    test('returns a valid URL for count', () {
      var x = "${Network.URL}/E/COUNT/";
      expect(Network.make_url("E", count: true), equalsIgnoringCase(x));
    });
    test('throws Error if format is invalid', () {
      expect(() => Network.make_url("ENDPOINT", format: "jpeg"), throwsArgumentError);
    });
    test('throws Error if columnName is provided without filterOperator', () {
      expect(() => Network.make_url("E", columnName: "E", filterValue: "E"), 
        throwsArgumentError);
    });
    test('throws Error if columnName is provided without filterValue', () {
      expect(() => Network.make_url("E", columnName: "E", filterOperator: "E"),
        throwsArgumentError);
    });
    test('throws Error if filter provided withouth columnName', () {
      expect(() => Network.make_url("E", filterValue: "E"), throwsArgumentError);
    });
    test('throws Error if rowsToShow is not a list', () {
      expect(() => Network.make_url("E", rowsToShow: "E"), throwsArgumentError);
    });
    test('throws Error if rowsToShow is not of proper size', () {
      expect(() => Network.make_url("E", rowsToShow: [0]), throwsArgumentError);
    });
  });
  
}