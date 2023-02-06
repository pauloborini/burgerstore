// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension OrderStatusMatch on OrderStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() errorLoading,
      required T Function() error401,
      required T Function() updateOrder}) {
    final v = this;
    if (v == OrderStatus.initial) {
      return initial();
    }

    if (v == OrderStatus.loading) {
      return loading();
    }

    if (v == OrderStatus.loaded) {
      return loaded();
    }

    if (v == OrderStatus.errorLoading) {
      return errorLoading();
    }

    if (v == OrderStatus.error401) {
      return error401();
    }

    if (v == OrderStatus.updateOrder) {
      return updateOrder();
    }

    throw Exception('OrderStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? errorLoading,
      T Function()? error401,
      T Function()? updateOrder}) {
    final v = this;
    if (v == OrderStatus.initial && initial != null) {
      return initial();
    }

    if (v == OrderStatus.loading && loading != null) {
      return loading();
    }

    if (v == OrderStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == OrderStatus.errorLoading && errorLoading != null) {
      return errorLoading();
    }

    if (v == OrderStatus.error401 && error401 != null) {
      return error401();
    }

    if (v == OrderStatus.updateOrder && updateOrder != null) {
      return updateOrder();
    }

    return any();
  }
}
