import 'package:domain/domain.dart';
import 'package:in_memory_services/in_memory_services.dart';

class ServiceProvider {
  ServiceProvider._();
  static final ServiceProvider _instance = ServiceProvider._();
  static ServiceProvider get instance => _instance;

  Future<void> init() async {
    _counterRepository = CounterRepositoryInMemoryImplementation();
    _counterUseCasesFactory = CounterUseCasesFactory(
      counterRepository: _counterRepository,
    );
  }

  late final ICounterRepository _counterRepository;
  late final ICounterUseCasesFactory _counterUseCasesFactory;

  ICounterUseCaseGetValue getCounterUseCaseGetValue() =>
      _counterUseCasesFactory.getCounterUseCaseGetValue();

  ICounterUseCaseExecuteOperation getCounterUseCaseExecuteOperation() =>
      _counterUseCasesFactory.getCounterUseCaseExecuteOperation();
}
