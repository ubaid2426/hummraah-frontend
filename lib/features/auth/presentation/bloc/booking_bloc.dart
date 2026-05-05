import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_bookings.dart';
import '../../data/models/booking_model.dart';

/// ===================== EVENTS =====================
abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// GET BOOKINGS EVENT
class GetBookingsEvent extends BookingEvent {}

/// ===================== STATES =====================
abstract class BookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingModel> bookings;

  BookingLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);

  @override
  List<Object?> get props => [message];
}

/// ===================== BLOC =====================
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookings getBookings;

  BookingBloc(this.getBookings) : super(BookingInitial()) {
    on<GetBookingsEvent>(_onGetBookings);
  }

  /// GET BOOKINGS HANDLER
  Future<void> _onGetBookings(
    GetBookingsEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());

    final result = await getBookings(NoParams());

    result.fold(
      (failure) => emit(BookingError("Failed to load bookings")),
      (data) => emit(BookingLoaded(data)),
    );
  }
}
