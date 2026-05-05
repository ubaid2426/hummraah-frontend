import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/booking_model.dart';
import '../repositories/booking_repository.dart';

class GetBookings implements UseCase<List<BookingModel>, NoParams> {
  final BookingRepository repository;

  GetBookings(this.repository);

  @override
  Future<Either<Failure, List<BookingModel>>> call(NoParams params) {
    return repository.getBookings();
  }
}
