import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// This class is the Cache Factory base. It will handle the basic stuff for you to create your own factories.
abstract class FactoryBase<E> {
  late Box<E> box;
  late Box<dynamic> metadataBox;

  late String boxName = 'BOX';
  late String metadataBoxName = 'METADATA_BOX';

  FactoryBase(TypeAdapter<E> adapter) {
    Hive.registerAdapter<E>(adapter);
  }

  /// Initiates the several [box]. This should be done only once.
  Future<void> init() async {
    try {
      if (!Hive.isBoxOpen(this.boxName)) {
        this.box = await Hive.openBox<E>(this.boxName);
      } else {
        this.box = Hive.box(this.boxName);
      }

      if (!Hive.isBoxOpen(this.metadataBoxName)) {
        this.metadataBox = await Hive.openBox<dynamic>(this.metadataBoxName);
      } else {
        this.metadataBox = Hive.box(this.metadataBoxName);
      }
    }catch(e){
      print(e);
    }
  }

  /// Closes the database. This should be done before closing the app to delete the actual cache of Hive.
  ///
  /// It's recommended to close it to free RAM space.
  Future<void> finish() async {
    Hive.close();
  }

  /// Removes every box data from the local database.
  Future invalidateCache() async {
    if (Hive.isBoxOpen(this.boxName)) {
      await box.deleteAll(box.keys);
      await this.box.clear();
    }

    if (Hive.isBoxOpen(this.metadataBoxName)) {
      await metadataBox.deleteAll(metadataBox.keys);
      await this.metadataBox.clear();
    }
  }

  /// Invalidate the cache. This should clear the cache every [deltaDays] time.
  /// This is an extra security to invalidate local cache every [deltaDays].
  Future<void> checkShouldInvalidateCache({int deltaDays = 7}) async {
    String? lastUpdateTime = this.getLocalLastUpdate();
    if (lastUpdateTime != null) {
      DateTime localUpdateTime = DateTime.parse(lastUpdateTime);
      final now = DateTime.now();
      final difference = now.difference(localUpdateTime).inDays;

      // Check if we have to invalidate in case our local date is outdated.
      if (difference >= deltaDays) {
        this.invalidateCache();
      }
    }
  }

  /// Handles if the cache should be invalidated.
  /// The class that extends from this class base need to implement it own functionality
  /// This is done when our local cache is outdated compared to server data.
  Future<void> checkCacheValidity();

  /// Store last time object was request from server.
  ///
  /// When [FactoryBase] request data from server. This method is use to save the time we request such data
  Future<void> updateLocalLastUpdate() async {
    String now = DateTime.now().toUtc().toString();
    print('[FactoryBase] Updating lastDateUpdate to $now');

    if (Hive.isBoxOpen(this.metadataBoxName)) this.metadataBox.put('LastUpdateTime', now);
  }

  /// Get the last time object was download
  String? getLocalLastUpdate() {
    if (Hive.isBoxOpen(this.metadataBoxName)) return this.metadataBox.get('LastUpdateTime');
    return null;
  }
}
