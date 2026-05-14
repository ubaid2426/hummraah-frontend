import 'package:hummraah/features/auth/data/models/booking_request_model.dart';
import 'package:hummraah/features/auth/data/models/booking_response_model.dart';

import '../models/booking_model.dart';
import '../../../../core/services/api/api_service.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getBookings();
   Future<BookingResponseModel> createBooking(BookingRequestModel request);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiService apiService;

  BookingRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookingModel>> getBookings() async {
    final response = await apiService.getBookings();

    return (response as List).map((e) => BookingModel.fromJson(e)).toList();
  }

  @override
  Future<BookingResponseModel> createBooking(
    BookingRequestModel request,
  ) async {
    final response = await apiService.createBooking(request.toJson());
    return BookingResponseModel.fromJson(response);
  }
}
