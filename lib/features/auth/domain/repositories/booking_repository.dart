import 'package:dartz/dartz.dart';
import 'package:hummraah/features/auth/data/models/booking_request_model.dart';
import 'package:hummraah/features/auth/data/models/booking_response_model.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/booking_model.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingModel>>> getBookings();
   Future<Either<Failure, BookingResponseModel>> createBooking(BookingRequestModel request);
}
