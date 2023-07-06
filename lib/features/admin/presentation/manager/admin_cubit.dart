import '../../../../../exports.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this.adminRepository) : super(const ProductControlInitial());

  final AdminRepository adminRepository;

  List<Product> products = [];
  List<Orders> orders = [];
  List<String> images = [];
  Analytics? analytics;
  Future<void> selectProductImages() async {
    emit(SelectProductImagesLoading());
    final images = await pickImages();
    this.images = images;
    emit(SelectProductImagesSuccess());
  }

  Future<void> addProduct({
    required String name,
    required String description,
    required String category,
    required double price,
    required double quantity,
  }) async {
    emit(const AddProductLoading());
    final addProduct = await adminRepository.addProduct(
      name: name,
      description: description,
      images: images,
      category: category,
      price: price,
      quantity: quantity,
    );
    addProduct.fold((error) => emit(AddProductError(error.message)), (_) async {
      await getAllProducts();
      images = [];
      emit(const AddProductSuccess());
    });
  }

  Future<void> getAllProducts() async {
    emit(const GetAllProductsLoading());
    final products = await adminRepository.getAllProducts();
    products.fold((error) => emit(GetAllProductsError(error.message)),
        (products) {
      this.products = products;
      emit(GetAllProductsSuccess());
    });
  }

  Future<void> getAllOrders() async {
    emit(const GetAllOrdersLoading());
    final orders = await adminRepository.getAllOrders();
    orders.fold((error) => emit(GetAllOrdersError(error.message)), (orders) {
      this.orders = orders;
      emit(GetAllOrdersSuccess());
    });
  }

  Future<void> getAnalytics() async {
    emit(const GetAnalyticsLoading());
    final analytics = await adminRepository.getAnalytics();
    analytics.fold((error) => emit(GetAnalyticsError(error.message)),
        (analytics) {
      this.analytics = analytics;
      emit(GetAnalyticsSuccess());
    });
  }

  Future<void> deleteProduct(String id) async {
    emit(const DeleteProductLoading());
    final products = await adminRepository.deleteProduct(id);
    products.fold((error) => emit(DeleteProductError(error.message)),
        (_) async {
      await getAllProducts();
      emit(const DeleteProductSuccess());
    });
  }
}
