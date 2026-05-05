import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/booking_model.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingModel>>> getBookings();
}
