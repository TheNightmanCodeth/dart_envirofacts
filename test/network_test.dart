import 'package:dart_envirofacts/envirofacts.dart';
import 'package:test/test.dart';

void main() async {
  group('API call', () {
    var api = EnvirofactsAPI.withEndpoint(ENDPOINT.semsActiveSites);
    test('withEndpoint', () async {      
      var response = await api.requestResults<SEMS>();
      expect(response, hasLength(10));
    });
    test('with responseCount', () async {
      var response = await api.requestResults<SEMS>(resultCount: 13);
      expect(response, hasLength(14)); // Must be 13 + 1 since we start at 0
    });
    test('with provided endpoint', () async {
      var responseCustomEndpoint = await api.requestResults<SEMS>(
        apiEndpoint: ENDPOINT.semsArchivedSites);
      var responseNormalEndpoint = await api.requestResults<SEMS>();
      expect(responseCustomEndpoint, hasLength(10));
      expect(responseCustomEndpoint, isNot(equals(responseNormalEndpoint)));
    });
  });  
}