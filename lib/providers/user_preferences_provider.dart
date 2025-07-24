// file: lib/providers/user_preferences_provider.dart
import 'package:flutter/foundation.dart';

class UserPreferencesProvider with ChangeNotifier {
  // Example: Store a set of allergen names
  final Set<String> _allergens = {};

  Set<String> get allergens => _allergens;

  void addAllergen(String allergen) {
    _allergens.add(allergen);
    notifyListeners(); // Notify widgets to rebuild
  }

  void removeAllergen(String allergen) {
    _allergens.remove(allergen);
    notifyListeners();
  }
}