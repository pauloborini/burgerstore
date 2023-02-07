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
      required T Function() updateOrder,
      required T Function() confirmRemoveProduct,
      required T Function() emptyBag,
      required T Function() success}) {
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

    if (v == OrderStatus.updateOrder) {
      return updateOrder();
    }

    if (v == OrderStatus.confirmRemoveProduct) {
      return confirmRemoveProduct();
    }

    if (v == OrderStatus.emptyBag) {
      return emptyBag();
    }

    if (v == OrderStatus.success) {
      return success();
    }

    throw Exception('OrderStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? errorLoading,
      T Function()? updateOrder,
      T Function()? confirmRemoveProduct,
      T Function()? emptyBag,
      T Function()? success}) {
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

    if (v == OrderStatus.updateOrder && updateOrder != null) {
      return updateOrder();
    }

    if (v == OrderStatus.confirmRemoveProduct && confirmRemoveProduct != null) {
      return confirmRemoveProduct();
    }

    if (v == OrderStatus.emptyBag && emptyBag != null) {
      return emptyBag();
    }

    if (v == OrderStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
