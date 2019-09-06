import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Offline {
  offline() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: FlareActor(
            'assets/Animation/Offline.flr',
            animation: 'idle',
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'No Internet Connection\n',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
