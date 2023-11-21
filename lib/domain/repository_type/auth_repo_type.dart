import 'dart:ffi';
import 'package:trans_virtual/domain/model/user_login.dart';
import 'package:trans_virtual/domain/repository_type/repository_base.dart';

abstract class AuthRepoType implements RepositoryBase {
  Future<UserLogin>login(String username, String password);
  Future<void>logout();
  Future<UserLogin?>autoLogin();
}