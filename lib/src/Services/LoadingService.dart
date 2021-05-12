import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Loadingbloc implements Bloc {
  final _loadingSubject = BehaviorSubject<bool>();
  Stream<bool> get loadingStream => _loadingSubject.stream;
  void setIsLoading(bool loading) => _loadingSubject.add(loading);

  @override
  void dispose() {}
}

final loadingBloc = Loadingbloc();
