import 'package:domain/domain.dart';

abstract interface class ICounterUseCasesFactory {
  ICounterUseCaseExecuteOperation getCounterUseCaseExecuteOperation();
  ICounterUseCaseGetValue getCounterUseCaseGetValue();
}
