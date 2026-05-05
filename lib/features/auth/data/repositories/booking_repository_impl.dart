import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BookingModel>>> getBookings() async {
    try {
      final bookings = await remoteDataSource.getBookings();
      return Right(bookings);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
