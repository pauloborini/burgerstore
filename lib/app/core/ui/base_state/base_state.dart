import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burgerstore/app/core/ui/helpers/loader.dart';
import 'package:burgerstore/app/core/ui/helpers/messages.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase> extends State<T>
    with Loader, Messages {
  late final C controller;

  @override
  initState() {
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
    super.initState();
  }

  onReady() {}
}
