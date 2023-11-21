import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trans_virtual/application/bloc/result_state.dart';
import 'package:trans_virtual/data/login_repo.dart';
import 'package:trans_virtual/domain/repository_type/auth_repo_type.dart';

class ResultLogout extends ResultStateType {}

class AuthBloc extends Cubit<ResultStateType> {
  final AuthRepoType repo;
  AuthBloc({AuthRepoType? repoType}): repo = repoType ?? AuthRepo(), super(ResultInitial());

  void autoLogin() async {
    emit(ResultLoading());
    final userLogin = await repo.autoLogin();
    if (userLogin != null) {
      emit(ResultSuccess(userLogin));
    } else {
      emit(ResultInitial());
    }
  }

  void login(String username, String password) async {
    emit(ResultLoading());
    try {
      final userLogin = await repo.login(username, password);
      if (userLogin.success) {
        emit(ResultSuccess(userLogin));
      } else {
        emit(ResultError(userLogin.errorMsg ?? "There seems to be a problem"));
      }

    } on DioException catch (e) {
      emit(ResultError(e.message ?? "There seems to be a problem"));
    }
  }

  void logout() async {
    emit(ResultLoading());
    await repo.logout();
    emit(ResultLogout());
  }
}

