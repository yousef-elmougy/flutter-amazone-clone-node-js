import '../../../../exports.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepository) : super(const HomeInitial());

  final HomeRepository homeRepository;
  List<Product> products = [];
  List<Product> productsSearch = [];
  List<Product> dealOfTheDayProducts = [];
  Product product = const Product(
    name: '',
    description: '',
    price: 0,
    quantity: 0,
    category: '',
    images: [],
    ratings: [],
    averageRating: 0,
  );

  Future<void> getProductsByCategory(String category) async {
    emit(const GetProductsByCategoryLoading());
    final products = await homeRepository.getProductsByCategory(category);
    products.fold((error) => emit(GetProductsByCategoryError(error.message)),
        (products) {
      this.products = products;
      emit(GetProductsByCategorySuccess());
    });
  }

  Future<void> search(String query) async {
    emit(const SearchLoading());
    final search = await homeRepository.search(query);
    search.fold((error) => emit(SearchError(error.message)), (productsSearch) {
      this.productsSearch = productsSearch;
      emit(SearchSuccess());
    });
  }

  Future<void> addRating({
    required String productId,
    required double rating,
  }) async {
    emit(const AddRatingLoading());
    final addRating = await homeRepository.addRating(
      productId: productId,
      rating: rating,
    );
    addRating.fold((error) => emit(AddRatingError(error.message)), (_) {
      getProduct(productId);
      emit(const AddRatingSuccess());
    });
  }

  Future<void> getProduct(String productId) async {
    emit(const GetProductLoading());
    final product = await homeRepository.getProduct(productId);
    product.fold((error) => emit(GetProductError(error.message)), (product) {
      this.product = product;
      emit(GetProductSuccess());
    });
  }

  Future<void> getDealOfTheDay() async {
    emit(const DealOfTheDayLoading());
    final products = await homeRepository.getDealOfTheDay();
    products.fold((error) => emit(DealOfTheDayError(error.message)),
        (products) {
      dealOfTheDayProducts = products;
      emit(DealOfTheDaySuccess());
    });
  }
}
