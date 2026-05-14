// lib/features/booking/presentation/bloc/booking_event.dart
// part of 'booking_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hummraah/features/auth/data/models/booking_request_model.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}
class GetBookingsEvent extends BookingEvent {}
class SubmitBookingEvent extends BookingEvent {
  final BookingRequestModel request;
  
  const SubmitBookingEvent(this.request);
  
  @override
  List<Object?> get props => [request];
}