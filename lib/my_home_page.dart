import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:my_counter_app/service_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ICounterUseCaseGetValue _usecaseGetValue =
      ServiceProvider.instance.getCounterUseCaseGetValue();
  final ICounterUseCaseExecuteOperation _usecaseExecuteOperation =
      ServiceProvider.instance.getCounterUseCaseExecuteOperation();

  bool _isLoading = true;
  bool _isError = false;
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  Future<void> _init() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _currentValue = await _usecaseGetValue.getCounterValue();
    } catch (e) {
      _isError = true;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _performOperation(CounterOperationType operationType) async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await _usecaseExecuteOperation.executeOperation(
        operationType: operationType,
      );
      _currentValue = await _usecaseGetValue.getCounterValue();
    } catch (e) {
      _isError = true;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String get _getText {
    if (_isError) {
      return 'Error';
    }
    if (_isLoading) {
      return 'Loading...';
    }
    return _currentValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              Text(
                _getText,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => _performOperation(CounterOperationType.increment),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => _performOperation(CounterOperationType.decrement),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
