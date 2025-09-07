import 'dart:math';
import '../models/stadium.dart';

/// Service for generating random stadiums
class StadiumGenerator {
  final Random _random = Random();

  /// List of potential stadium names
  static const List<String> _stadiumNames = [
    'Memorial Stadium',
    'Victory Field',
    'Championship Arena',
    'Iron Bowl',
    'Thunder Dome',
    'Legends Field',
    'Pioneer Stadium',
    'Eagle\'s Nest',
    'Warrior Field',
    'Champion\'s Coliseum',
    'Freedom Stadium',
    'Liberty Bowl',
    'Heritage Field',
    'Glory Stadium',
    'Unity Arena',
    'Honor Field',
    'Pride Stadium',
    'Courage Bowl',
    'Valor Arena',
    'Spirit Field',
    'Power Stadium',
    'Elite Arena',
    'Crown Field',
    'Royal Stadium',
    'Imperial Bowl',
    'Supreme Arena',
    'Grand Stadium',
    'Majestic Field',
    'Noble Arena',
    'Prime Stadium',
  ];

  /// List of potential cities/locations
  static const List<String> _locations = [
    'Atlanta, GA',
    'Boston, MA',
    'Chicago, IL',
    'Dallas, TX',
    'Denver, CO',
    'Detroit, MI',
    'Houston, TX',
    'Los Angeles, CA',
    'Miami, FL',
    'Minneapolis, MN',
    'New York, NY',
    'Philadelphia, PA',
    'Phoenix, AZ',
    'San Francisco, CA',
    'Seattle, WA',
    'Tampa, FL',
    'Cleveland, OH',
    'Indianapolis, IN',
    'Jacksonville, FL',
    'Kansas City, MO',
    'Las Vegas, NV',
    'Nashville, TN',
    'New Orleans, LA',
    'Pittsburgh, PA',
    'San Diego, CA',
    'St. Louis, MO',
    'Buffalo, NY',
    'Cincinnati, OH',
    'Green Bay, WI',
    'Charlotte, NC',
  ];

  /// Generates a random stadium
  Stadium generateStadium() {
    final int capacity = _generateCapacity();
    return Stadium(
      name: _generateName(),
      location: _generateLocation(),
      turfType: _generateTurfType(),
      roofType: _generateRoofType(),
      capacity: capacity,
      yearBuilt: _generateYearBuilt(),
      luxurySuites: _generateLuxurySuites(capacity),
      concessionsRating: _generateRating(),
      parkingRating: _generateRating(),
      homeFieldAdvantage: _generateHomeFieldAdvantage(),
    );
  }

  /// Generates a random stadium name
  String _generateName() {
    return _stadiumNames[_random.nextInt(_stadiumNames.length)];
  }

  /// Generates a random location
  String _generateLocation() {
    return _locations[_random.nextInt(_locations.length)];
  }

  /// Generates a random turf type
  TurfType _generateTurfType() {
    // 60% grass, 40% artificial
    return _random.nextDouble() < 0.6 ? TurfType.grass : TurfType.artificial;
  }

  /// Generates a random roof type
  RoofType _generateRoofType() {
    final double rand = _random.nextDouble();
    if (rand < 0.6) {
      return RoofType.open; // 60% open
    } else if (rand < 0.8) {
      return RoofType.retractable; // 20% retractable
    } else {
      return RoofType.dome; // 20% dome
    }
  }

  /// Generates a random capacity between 45,000 and 85,000
  int _generateCapacity() {
    return 45000 + _random.nextInt(40001); // 45,000 to 85,000
  }

  /// Generates a random year built between 1960 and 2025
  int _generateYearBuilt() {
    return 1960 + _random.nextInt(66); // 1960 to 2025
  }

  /// Generates number of luxury suites based on capacity
  int _generateLuxurySuites(int capacity) {
    final int baseCapacity = 45000;
    final int maxCapacity = 85000;
    
    // Scale luxury suites between 20-200 based on capacity
    final double ratio = (capacity - baseCapacity) / (maxCapacity - baseCapacity);
    final int minSuites = 20;
    final int maxSuites = 200;
    
    return (minSuites + (ratio * (maxSuites - minSuites))).round();
  }

  /// Generates a rating between 1-100 using normal distribution
  int _generateRating() {
    // Use Box-Muller transform for normal distribution
    final double u1 = _random.nextDouble();
    final double u2 = _random.nextDouble();
    final double z0 = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
    
    // Scale to mean=75, stddev=15
    final double rating = 75 + (z0 * 15);
    
    // Clamp to 1-100 range and round up
    return max(1, min(100, rating.ceil()));
  }

  /// Generates home field advantage rating between 1-10
  int _generateHomeFieldAdvantage() {
    // Use normal distribution centered around 5-6
    final double u1 = _random.nextDouble();
    final double u2 = _random.nextDouble();
    final double z0 = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
    
    // Scale to mean=5.5, stddev=1.5
    final double advantage = 5.5 + (z0 * 1.5);
    
    // Clamp to 1-10 range and round up
    return max(1, min(10, advantage.ceil()));
  }
}
