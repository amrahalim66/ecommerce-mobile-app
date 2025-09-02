import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product.dart';
import '../cubits/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  static final CartCubit _instance = CartCubit._internal();
  factory CartCubit() => _instance;
  CartCubit._internal() : super(CartLoaded(items: []));
  // Add
  void addToCart(Product product) {
    if (state is CartLoaded) {
      final current = List<CartItem>.from((state as CartLoaded).items);
      final index = current.indexWhere((item) => item.product.id == product.id);

      if (index != -1) {
        final updated = current[index].quantity + 1;
        current[index] = CartItem(product: product, quantity: updated);
      } else {
        current.add(CartItem(product: product, quantity: 1));
      }

      emit(CartLoaded(items: current));
    }
  }

  void increaseQuantity(Product product) {
    if (state is CartLoaded) {
      final current = List<CartItem>.from((state as CartLoaded).items);
      final index = current.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        final updatedItem = CartItem(
          product: product,
          quantity: current[index].quantity + 1,
        );
        current[index] = updatedItem;
        emit(CartLoaded(items: current));
      }
    }
  }

  void decreaseQuantity(Product product) {
    if (state is CartLoaded) {
      final current = List<CartItem>.from((state as CartLoaded).items);
      final index = current.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        final currentItem = current[index];
        final newQty = currentItem.quantity - 1;
        if (newQty <= 0) {
          current.removeAt(index);
        } else {
          current[index] = CartItem(product: product, quantity: newQty);
        }
        emit(CartLoaded(items: current));
      }
    }
  }

  //Remove
  void removeFromCart(Product product) {
    if (state is CartLoaded) {
      final updated = (state as CartLoaded).items
          .where((item) => item.product.id != product.id)
          .toList();
      emit(CartLoaded(items: updated));
    }
  }

  Future<void> saveCartToFirestore() async {
    if (state is CartLoaded) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final cartData = (state as CartLoaded).items
          .map(
            (item) => {
              'id': item.product.id,
              'title': item.product.title,
              'price': item.product.price,
              'quantity': item.quantity,
            },
          )
          .toList();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart')
          .doc('items')
          .set({'items': cartData});
    }
  }
}
