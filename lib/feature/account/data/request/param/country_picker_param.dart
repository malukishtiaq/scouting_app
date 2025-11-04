import '../../../../../core/params/base_params.dart';

class CountryPickerParam extends BaseParams {
  final String? search_country;

  CountryPickerParam({
    required this.search_country,
  });

  @override
  Map<String, dynamic> toMap() => {
        "SearchString":
            search_country?.isNotEmpty == true ? search_country : "",
      };
}
