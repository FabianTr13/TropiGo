import 'package:TropiGo/src/Services/LoadingService.dart';
import 'package:flutter/material.dart';

class RunLoading extends StatelessWidget {
  const RunLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: loadingBloc.loadingStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final bool loading = snapshot.data ?? false;
        return loading
            ? Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()))
            : Container();
      });
}
