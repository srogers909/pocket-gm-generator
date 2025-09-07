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
