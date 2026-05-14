// lib/features/booking/presentation/bloc/booking_state.dart


// part of 'booking_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hummraah/features/auth/data/models/booking_model.dart';
import 'package:hummraah/features/auth/data/models/booking_response_model.dart';
// part of "booking_bloc.dart";

abstract class BookingState extends Equatable {
  const BookingState();
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

class BookingSuccess extends BookingState {
  final BookingResponseModel response;
  
  const BookingSuccess(this.response);
  
  @override
  List<Object?> get props => [response];
}

class BookingError extends BookingState {
  final String message;
  
  const BookingError(this.message);
  
  @override
  List<Object?> get props => [message];
}