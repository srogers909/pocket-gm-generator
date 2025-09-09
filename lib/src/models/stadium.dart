/// Enum representing different types of playing surface
enum TurfType {
  grass,
  artificial,
}

/// Enum representing different roof configurations
enum RoofType {
  open,
  retractable,
  dome,
}

/// Represents a football stadium with various attributes
class Stadium {
  final String name;
  final String location;
  final TurfType turfType;
  final RoofType roofType;
  final int capacity;
  final int yearBuilt;
  final int luxurySuites;
  final int concessionsRating; // 1-100
  final int parkingRating; // 1-100
  final int homeFieldAdvantage; // 1-10

  const Stadium({
    required this.name,
    required this.location,
    required this.turfType,
    required this.roofType,
    required this.capacity,
    required this.yearBuilt,
    required this.luxurySuites,
    required this.concessionsRating,
    required this.parkingRating,
    required this.homeFieldAdvantage,
  });

  /// Converts the Stadium to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'turfType': turfType.name,
      'roofType': roofType.name,
      'capacity': capacity,
      'yearBuilt': yearBuilt,
      'luxurySuites': luxurySuites,
      'concessionsRating': concessionsRating,
      'parkingRating': parkingRating,
      'homeFieldAdvantage': homeFieldAdvantage,
    };
  }

  /// Creates a Stadium from a JSON representation
  factory Stadium.fromJson(Map<String, dynamic> json) {
    return Stadium(
      name: json['name'] as String,
      location: json['location'] as String,
      turfType: TurfType.values.firstWhere(
        (e) => e.name == json['turfType'],
      ),
      roofType: RoofType.values.firstWhere(
        (e) => e.name == json['roofType'],
      ),
      capacity: json['capacity'] as int,
      yearBuilt: json['yearBuilt'] as int,
      luxurySuites: json['luxurySuites'] as int,
      concessionsRating: json['concessionsRating'] as int,
      parkingRating: json['parkingRating'] as int,
      homeFieldAdvantage: json['homeFieldAdvantage'] as int,
    );
  }

  @override
  String toString() {
    return 'Stadium('
        'name: $name, '
        'location: $location, '
        'turfType: $turfType, '
        'roofType: $roofType, '
        'capacity: $capacity, '
        'yearBuilt: $yearBuilt, '
        'luxurySuites: $luxurySuites, '
        'concessionsRating: $concessionsRating, '
        'parkingRating: $parkingRating, '
        'homeFieldAdvantage: $homeFieldAdvantage'
        ')';
  }
}
