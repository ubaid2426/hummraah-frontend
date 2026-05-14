// lib/features/booking/domain/usecases/create_booking.dart
import 'package:dartz/dartz.dart';
import 'package:hummraah/core/error/failures.dart';
import 'package:hummraah/features/auth/data/models/booking_request_model.dart';
import 'package:hummraah/features/auth/data/models/booking_response_model.dart';
import '../repositories/booking_repository.dart';

class CreateBooking {
  final BookingRepository repository;

  CreateBooking(this.repository);

  Future<Either<Failure, BookingResponseModel>> call(BookingRequestModel request) {
    return repository.createBooking(request);
  }
}