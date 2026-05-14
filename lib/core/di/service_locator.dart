// injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:hummraah/core/services/api/api_service.dart';
import 'package:hummraah/core/services/api/api_client.dart';
import 'package:hummraah/features/auth/domain/usecases/singup.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/booking_bloc.dart';
import '../../features/auth/domain/usecases/send_otp.dart';
import '../../features/auth/domain/usecases/verify_otp.dart';
import '../../features/auth/domain/usecases/create_booking.dart'; // Add this import
// import '../../features/auth/domain/usecases/signup.dart';
import '../../features/auth/domain/usecases/get_bookings.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/repositories/booking_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/booking_repository_impl.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/booking_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // API SERVICE
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<ApiClient>()));

  // AUTH - Data Sources (REGISTER THIS FIRST)
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiService>()),
  );
  
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(sl<ApiService>()),
  );

  // AUTH - Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthDataSource>()),
  );
  
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(sl<BookingRemoteDataSource>()),
  );

  // AUTH - Use Cases
  sl.registerLazySingleton(() => SendOtp(sl<AuthRepository>()));
  sl.registerLazySingleton(() => VerifyOtp(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Signup(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetBookings(sl<BookingRepository>()));
  sl.registerLazySingleton(() => CreateBooking(sl<BookingRepository>())); // Add this line

  // AUTH - Bloc
  sl.registerFactory(() => AuthBloc(
    sendOtp: sl<SendOtp>(),
    verifyOtp: sl<VerifyOtp>(),
    signup: sl<Signup>(),
  ));
  
  // Update BookingBloc registration to include both usecases
  sl.registerFactory(() => BookingBloc(
    getBookings: sl<GetBookings>(),
    createBooking: sl<CreateBooking>(),
  ));
}