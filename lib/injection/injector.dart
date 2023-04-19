import 'package:get_it/get_it.dart';
import 'package:todo_list/injection/bloc_injection.dart';
import 'package:todo_list/injection/infra_injection.dart';
import 'package:todo_list/injection/repository_injection.dart';
import 'package:todo_list/injection/use_case_injection.dart';

GetIt injector = GetIt.instance;

void initDependenciesInjection() {
  InfraInjection.inject();
  RepositoryInjection.inject();
  UseCaseInjection.inject();
  BlocInjection.inject();
}
