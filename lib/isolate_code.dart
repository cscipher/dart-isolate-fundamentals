import 'dart:async';
import 'dart:isolate';

class FibModel {
  final int n;
  final SendPort? sendport;

  FibModel({required this.n, this.sendport});
}

class IsolateFundamental {
  static int fibonacciRecursive(int n) =>
      n <= 2 ? 1 : fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);

  static Future<int> productTillN(int n) async {
    await Future.delayed(Duration(seconds: 50 - n));
    int x = n, ans = 1;
    for (int i = 1; i <= x; i++) {
      ans *= i;
    }
    return ans;
  }

  static void fibonacci(FibModel fm) async {
    // final int ans = await productTillN(fm.n);
    final int ans = fibonacciRecursive(fm.n);
    print(ans);
    fm.sendport?.send(ans);
  }

  Future<int> initFib(int n) async {
    final receiverPort = ReceivePort();

    Isolate.spawn<FibModel>(
        fibonacci, FibModel(n: n, sendport: receiverPort.sendPort));

    return _subscribeToPort<int>(receiverPort);
  }

  Future<T> _subscribeToPort<T>(ReceivePort port) async {
    var completer = Completer<T>();
    port.listen((result) async {
      completer.complete(await result);
    });
    return completer.future;
  }
}
