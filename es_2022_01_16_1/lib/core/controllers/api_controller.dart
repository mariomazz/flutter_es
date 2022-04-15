/* class ApiController<T> {
  Future<T> Function() fetchData;

  // BLOC

  ApiController({required this.fetchData});

  T? _dataSaved;

  Stream<T> get stream => streamData();

  Stream<T> streamData() async* {
    if (_dataSaved == null) {
      final data = await fetchData.call();
      _dataSaved = data;
      yield data;
    } else {
      yield _dataSaved!;
    }
  }

  void clear() => {_dataSaved = null};

  // END BLOC

} */
