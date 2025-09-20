import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_system/data/model/response/item_response_model.dart';

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class ItemRemoteDatasource {
  Future<Either<String, ItemResponseModel>> getItems() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/items'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return Right(ItemResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
