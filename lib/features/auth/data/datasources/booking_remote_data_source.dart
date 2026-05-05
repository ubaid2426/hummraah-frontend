import '../models/booking_model.dart';
import '../../../../core/services/api/api_service.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getBookings();
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiService apiService;

  BookingRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookingModel>> getBookings() async {
    final response = await apiService.getBookings();

    return (response as List).map((e) => BookingModel.fromJson(e)).toList();
  }
}
