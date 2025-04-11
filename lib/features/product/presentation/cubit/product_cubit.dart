import 'package:eagri_pro/features/product/data/models/params/publish_product_model.dart';
import 'package:eagri_pro/features/product/domain/usecases/get_form_product_by_id_usecase.dart';
import 'package:eagri_pro/features/product/domain/usecases/get_type_product_usecase.dart';
import 'package:eagri_pro/features/product/domain/usecases/publish_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../packages/models/formulaire_model.dart';
import '../../data/models/params/search_product_article_params.dart';
import '../../domain/usecases/search_article_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetTypeProductUsecase getTypeProductUsecase;
  final SearchArticleProductUsecase searchArticleProductUsecase;
  final GetFormProductByIdUsecase getFormProductByIdUsecase;
  final PublishProductUsecase publishProductUsecase;
  ProductCubit(
      {required this.getTypeProductUsecase,
      required this.getFormProductByIdUsecase,
      required this.publishProductUsecase,
      required this.searchArticleProductUsecase})
      : super(ProductInitial());

  Future<void> getTypePublication() async {
    emit(state.copyWith(
        isLoading: true, errorMessage: '', status: Status.loading));
    final result = await getTypeProductUsecase.call(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
          errorMessage: failure.errorMessage,
          isLoading: false,
          status: Status.error)),
      (listTypePublication) => emit(state.copyWith(
          listTypePublication: listTypePublication,
          isLoading: false,
          status: Status.success,
          listProduct: [])),
    );
  }

  Future<void> searchArticleProduct(SearchProductArticleParams query) async {
    try {
      emit(state.copyWith(isLoading: true, status: Status.loading));
      final result = await searchArticleProductUsecase.call(query);
      result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            isLoading: false,
            status: Status.error)),
        (listProduct) => emit(state.copyWith(
            listProduct: listProduct,
            isLoading: false,
            status: Status.success)),
      );
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), status: Status.error));
    }
  }

  Future<List<DataFormulaireModel>> getFormProductById(int id) async {
    try {
      emit(state.copyWith(isLoading: true, status: Status.loading));
      final result = await getFormProductByIdUsecase.call(id);
      return result.fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.errorMessage,
            isLoading: false,
            status: Status.error));
        return [];
      }, (formProduct) {
        emit(state.copyWith(isLoading: false, status: Status.success));
        return formProduct;
      });
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), status: Status.error));
      return [];
    }
  }

  Future<bool> publishProduct(PublishProductModel data) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final result = await publishProductUsecase.call(data);
     return result.fold((failure) {
        emit(state.copyWith(
            errorMessage: failure.errorMessage,
            isLoading: false,
            status: Status.error));
        return false;
      }, (isSuccess) {
        emit(state.copyWith(status: Status.success));
        return isSuccess;
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
      return false;
    }
  }

  resetListProduct() {
    emit(state.copyWith(listProduct: []));
  }
}
