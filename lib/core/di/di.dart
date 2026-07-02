import 'package:get_it/get_it.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/data/datasources/remote_data_source.dart';
import 'package:kasi_chat/core/data/datasources/remote_data_source_impl.dart';
import 'package:kasi_chat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kasi_chat/features/auth/domain/domain.dart';
import 'package:kasi_chat/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:kasi_chat/features/chat/domain/usecase/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerFactory<SupabaseClient>(() => Supabase.instance.client);

  final database = AppDatabaseImpl(sl());
  sl..registerSingleton<AppDatabase>(database)

  // Data Sources
  ..registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()))

  // Repositories
  ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
  ..registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(client: sl(), db: sl(), remoteDataSource: sl()),
  )

  // Auth Use Cases
  ..registerLazySingleton(() => SignInUseCase(sl()))
  ..registerLazySingleton(() => SignUpUseCase(sl()))
  ..registerLazySingleton(() => SignOutUseCase(sl()))
  ..registerLazySingleton(() => ResetPasswordUseCase(sl()))
  ..registerLazySingleton(() => UpdateProfileUseCase(sl()))
  ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
  ..registerLazySingleton(() => GetUserProfileUseCase(sl()))

  // Chat Use Cases
  ..registerLazySingleton(() => GetChatsUseCase(sl()))
  ..registerLazySingleton(() => WatchChatsUseCase(sl()))
  ..registerLazySingleton(() => GetMessagesUseCase(sl()))
  ..registerLazySingleton(() => WatchMessagesUseCase(sl()))
  ..registerLazySingleton(() => SendMessageUseCase(sl()))
  ..registerLazySingleton(() => CreateChatUseCase(sl()))
  ..registerLazySingleton(() => DeleteChatUseCase(sl()))
  ..registerLazySingleton(() => SearchUsersUseCase(sl()))
  ..registerLazySingleton(() => GetUserByIdUseCase(sl()))
  ..registerLazySingleton(() => GetChatUserIdsUseCase(sl()))
  ..registerLazySingleton(() => SyncChatsUseCase(sl()))
  ..registerLazySingleton(() => SyncChatMessagesUseCase(sl()))
  ..registerLazySingleton(() => UpdateUserStatusUseCase(sl()))
  ..registerLazySingleton(() => UploadFileUseCase(sl()))
  ..registerLazySingleton(() => GetUsersUseCase(sl()));

  // Register dependencies here
}
