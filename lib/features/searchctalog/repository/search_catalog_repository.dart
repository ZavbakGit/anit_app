import 'dart:convert';
import 'package:anit_app/features/searchctalog/model/model.dart';
import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/services/api_provider.dart';
import 'package:http/http.dart';

class SearchCatalogRepository {
  final ApiProvider _apiProvider;

  SearchCatalogRepository(LoginData _loginData)
      : this._apiProvider = ApiProvider(loginData: _loginData);

  Future<ResponseSearch> getListCatalog(String type,String searchText) async {

    final url = 'catalog?catalog=$type&count=30&offset=0&search=$searchText&all=${false}';

    final Response response = await _apiProvider.request(uri: url);
    final bodyUtf8 = utf8.decode(response.bodyBytes);

    return ResponseSearch.fromJson(json.decode(bodyUtf8));
  }

  Future<ResponseSearch> getListCatalogAll(String type) async {

    final search = "";

    final url = 'catalog?catalog=$type&count=30&offset=0&search=$search';

    final Response response = await _apiProvider.request(uri: url);
    final bodyUtf8 = utf8.decode(response.bodyBytes);

    return ResponseSearch.fromJson(json.decode(bodyUtf8));
  }

}
