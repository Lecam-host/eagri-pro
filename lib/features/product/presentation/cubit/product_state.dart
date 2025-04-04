import 'package:eagri_pro/features/product/data/models/type_product_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enum.dart';
import '../../data/models/result_product_search_model.dart';

final class ProductInitial extends ProductState {}

class ProductState extends Equatable {
  final bool isLoading;
  final Status status;
  final String? errorMessage;
  final List<TypeProductModel> listTypePublication;
  final List<ResultProductSearchModel> listProduct;

  const ProductState(
      {this.isLoading = false,
      this.status = Status.initial,
      this.errorMessage,
      this.listTypePublication = const [],
      this.listProduct = const []});
  ProductState copyWith(
      {bool? isLoading,
      String? errorMessage,
      List<TypeProductModel>? listTypePublication,
      Status? status,
      List<ResultProductSearchModel>? listProduct}) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      listTypePublication: listTypePublication ?? this.listTypePublication,
      listProduct: listProduct ?? this.listProduct,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, errorMessage, listTypePublication, listProduct, status];
}
