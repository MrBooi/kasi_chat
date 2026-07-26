import 'package:get_it/get_it.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/data/datasources/remote_data_source.dart';
import 'package:kasi_chat/core/data/datasources/remote_data_source_impl.dart';
import 'package:kasi_chat/core/data/repositories/auth_repository_impl.dart';
import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';
import 'package:kasi_chat/core/domain/usecase/chat_usecase/chat_usecases.dart';
import 'package:kasi_chat/features/app/bloc/app_bloc.dart';
import 'package:kasi_chat/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kasi_chat/features/auth/login/cubit/login_cubit.dart';
import 'package:kasi_chat/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:kasi_chat/core/data/repositories/chat_repository_impl.dart';
import 'package:kasi_chat/features/chat_list/bloc/chat_list_bloc.dart';
import 'package:kasi_chat/features/chat_list/bloc/create_chat/create_chat_cubit.dart';
import 'package:kasi_chat/features/chat_list/bloc/delete_chat/delete_chat_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerFactory<SupabaseClient>(() => Supabase.instance.client);

  final database = AppDatabaseImpl(sl());
  sl
    ..registerSingleton<AppDatabase>(database)
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
    ..registerLazySingleton(() => UserChangeUsecase(sl()))
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
    ..registerLazySingleton(() => GetUsersUseCase(sl()))
    // Register dependencies here
    // Register blocs or Cubits
    ..registerLazySingleton<AppBloc>(
      () => AppBloc(
        useChangeUsecase: sl(),
        signOutUsecase: sl(),
      ),
    )
    ..registerLazySingleton<LoginCubit>(
      () => LoginCubit(
        signInUseCase: sl(),
      ),
    )
    ..registerLazySingleton<SignUpCubit>(
      () => SignUpCubit(signUpUseCase: sl()),
    )
    ..registerLazySingleton<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(resetPasswordUseCase: sl()),
    )
    ..registerLazySingleton<ChatListBloc>(
      () => ChatListBloc(
        getChatsUseCase: sl(),
        watchChatsUseCase: sl(),
        getUserByIdUseCase: sl(),
        getChatUserIdsUseCase: sl(),
        syncChatsUseCase: sl(),
        getCurrentUserUseCase: sl(),
      ),
    )
    ..registerLazySingleton<DeleteChatCubit>(
      () => DeleteChatCubit(deleteChatUseCase: sl()),
    )
    ..registerLazySingleton<CreateChatCubit>(
      () => CreateChatCubit(createChatUseCase: sl()),
    );
}
