import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category/category_model.dart';
import '../../../data/repositories/category_repository.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super( CategoryInitialState() ) {
    _initialize();
  }

  final _categoryRepository = CategoryRepository();

  void _initialize() async {
    emit( CategoryLoadingState(state.categories) );
    try {
      List<CategoryModel> categories = await _categoryRepository.fetchAllCategories();
      emit( CategoryLoadedState(categories) );
    }
    catch(ex) {
      emit( CategoryErrorState(ex.toString(), state.categories) );
    }
  }
}