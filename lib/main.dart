import 'package:emoji_scavenger_hunt/app.dart';
import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:emoji_scavenger_hunt/model/service_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      ServiceProvider(
        child: GameBlocProvider(
          child: App(),
        ),
      ),
    );
