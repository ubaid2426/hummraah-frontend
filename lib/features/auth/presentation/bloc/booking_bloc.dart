import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hummraah/features/auth/domain/usecases/create_booking.dart';
import 'package:hummraah/features/auth/presentation/bloc/booking_event.dart';
import 'package:hummraah/features/auth/presentation/bloc/booking_state.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_bookings.dart';
import '../../data/models/booking_model.dart';

/// ===================== BLOC =====================
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookings? getBookings;
  final CreateBooking? createBooking;
  
  // ✅ Use named parameters with curly braces
  BookingBloc({
    this.getBookings,
    this.createBooking,
  }) : super(BookingInitial()) {
    if (getBookings != null) {
      on<GetBookingsEvent>(_onGetBookings);
    }
    if (createBooking != null) {
      on<SubmitBookingEvent>(_onSubmitBooking);
    }
  }

  Future<void> _onGetBookings(
    GetBookingsEvent event,
    Emitter<BookingState> emit,
  ) async {
    if (getBookings == null) return;
    
    emit(BookingLoading());

    final result = await getBookings!(NoParams());

    result.fold(
      (failure) =>
          emit(BookingError(failure.message ?? "Failed to load bookings")),
      (data) => emit(BookingLoaded(data)),
    );
  }

  Future<void> _onSubmitBooking(
    SubmitBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    if (createBooking == null) return;
    
    emit(BookingLoading());
    
    final result = await createBooking!(event.request);
    
    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (response) => emit(BookingSuccess(response)),
    );
  }
}