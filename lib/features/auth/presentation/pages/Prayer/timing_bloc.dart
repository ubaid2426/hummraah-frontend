// lib/blocs/timing_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/prayer_model.dart';
import 'prayer_api_service.dart';
// import '../models/prayer_times_model.dart';
// import '../services/prayer_api_service.dart';

// Define States
abstract class TimingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimingInitial extends TimingState {}

class TimingLoading extends TimingState {}  // Add this line

class TimingLoaded extends TimingState {
  final PrayerTimesModel prayerTimes;
  TimingLoaded(this.prayerTimes);
  @override
  List<Object?> get props => [prayerTimes];
}

class TimingError extends TimingState {
  final String message;
  TimingError(this.message);
  @override
  List<Object?> get props => [message];
}

// Define Events
abstract class TimingEvent {}

class LoadTimingEvent extends TimingEvent {}

// Bloc Implementation
class TimingBloc extends Bloc<TimingEvent, TimingState> {
  final double latitude;
  final double longitude;
  final int method;
  final int madhab;
  final PrayerApiService apiService;

  TimingBloc({
    required this.latitude,
    required this.longitude,
    required this.method,
    required this.madhab,
  }) : apiService = PrayerApiService(), super(TimingInitial()) {
    on<LoadTimingEvent>(_onLoadTimingEvent);
  }

  Future<void> _onLoadTimingEvent(
      LoadTimingEvent event, Emitter<TimingState> emit) async {
    try {
      emit(TimingLoading());  // Now this will work
      
      print('📍 Fetching prayer times for: Lat=$latitude, Long=$longitude');
      print('⚙️ Method: $method, Madhab: $madhab');
      
      final prayerTimes = await apiService.getPrayerTimes(
        latitude: latitude,
        longitude: longitude,
        method: method,
        madhab: madhab,
      );
      
      emit(TimingLoaded(prayerTimes));
    } catch (e) {
      print('❌ Error: $e');
      emit(TimingError('Failed to load prayer times: ${e.toString().replaceAll('Exception: ', '')}'));
    }
  }
}