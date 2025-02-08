import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:raddi_web/api/api.dart';
import 'package:raddi_web/models/admin/admin.dart';
import 'package:raddi_web/core/constants/end_point_constant.dart';
import 'package:raddi_web/models/generic/data_exception_model.dart';

class AdminProvider {
  Future<Either<DataException, IncomeResponseModel>> getIncome() async {
    try {
      final response = await Api().tokenDio.get(EndPointConstant.income);

      return Right(IncomeResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(DataException(exception: e));
    } catch (e) {
      return Left(DataException(details: e.toString()));
    }
  }

  Future<Either<DataException, StadisticsResponseModel>> getStadistic() async {
    try {
      final response = await Api().tokenDio.get(EndPointConstant.stadistics);

      return Right(StadisticsResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(DataException(exception: e));
    } catch (e) {
      return Left(DataException(details: e.toString()));
    }
  }

  Future<Either<DataException, List<PaymentStadisticsResponseModel>>>
      getPaymentStadistics() async {
    try {
      final response =
          await Api().tokenDio.get(EndPointConstant.paymentMethods);

      return Right(List.from((response.data)
          .map((x) => PaymentStadisticsResponseModel.fromJson(x))));
    } on DioException catch (e) {
      return Left(DataException(exception: e));
    } catch (e) {
      return Left(DataException(details: e.toString()));
    }
  }
}
