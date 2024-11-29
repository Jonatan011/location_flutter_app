import 'package:mobx/mobx.dart';

part 'bottom_navigation_store.g.dart';

class BottomNavigationStore = _BottomNavigationStore with _$BottomNavigationStore;

abstract class _BottomNavigationStore with Store {
  @observable
  int selectedIndex = 0;

  @action
  void setSelectedIndex(int index) {
    selectedIndex = index;
  }
}
