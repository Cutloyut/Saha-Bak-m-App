import 'package:saha_bakim/features/field-service/providers/filter_provider.dart';

extension FilterStatusExtentions on FilterStatusEnum {
  String get trName {
    switch (this) {
      case FilterStatusEnum.all:
        return 'Tüm';
      case FilterStatusEnum.cancelled:
        return 'İptal Edilen';
      case FilterStatusEnum.completed:
        return 'Tamamlanan';
      case FilterStatusEnum.inProgress:
        return 'Devam Eden';
      case FilterStatusEnum.open:
        return 'Açık Olan';
      case FilterStatusEnum.nulls:
        return "";
    }
  }
}
