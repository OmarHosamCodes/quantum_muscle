import 'package:quantum_muscle/library.dart';

class QmNiceTouch extends StatelessWidget {
  const QmNiceTouch({
    required this.child, super.key,
    this.color = ColorConstants.primaryColor,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final vWidth = MediaQuery.of(context).size.width;
    final vHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(vWidth, vHeight),
          foregroundPainter:
              DotPainter(dotColor: color, dotRadius: 0.35, spacing: 10),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: ConnectivityChecker(),
        ),
      ],
    );
  }
}

class ConnectivityChecker extends StatefulWidget {
  const ConnectivityChecker({
    super.key,
  });

  @override
  State<ConnectivityChecker> createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      "Couldn't check connectivity status $e".log();
      return;
    }

    if (!mounted) {
      return Future.value();
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _connectionStatus == ConnectivityResult.none,
      child: QmBlock(
        borderRadius: BorderRadius.zero,
        height: 40,
        width: double.maxFinite,
        color: ColorConstants.errorColor,
        child: QmText(
          text: S.current.NetworkError,
        ),
      ),
    );
  }
}
