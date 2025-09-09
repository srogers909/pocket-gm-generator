import 'team.dart';

/// Represents a division in the league containing 4 teams
class Division {
  final String name;
  final List<Team> teams;

  Division({
    required this.name,
    required this.teams,
  });

  /// Gets the number of teams in the division
  int get teamCount => teams.length;

  /// Gets the average rating of all teams in the division
  double get averageRating {
    if (teams.isEmpty) return 0.0;
    final totalRating = teams.fold<double>(0.0, (sum, team) => sum + team.averageOverallRating);
    return totalRating / teams.length;
  }

  /// Gets teams sorted by average rating (best to worst)
  List<Team> get teamsByRating {
    final sortedTeams = List<Team>.from(teams);
    sortedTeams.sort((a, b) => b.averageOverallRating.compareTo(a.averageOverallRating));
    return sortedTeams;
  }

  /// Converts the Division to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'teams': teams.map((team) => team.toJson()).toList(),
      // Computed properties
      'teamCount': teamCount,
      'averageRating': averageRating,
    };
  }

  /// Creates a Division from a JSON representation
  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      name: json['name'] as String,
      teams: (json['teams'] as List<dynamic>)
          .map((teamJson) => Team.fromJson(teamJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('=== $name ===');
    buffer.writeln('Teams: $teamCount');
    buffer.writeln('Average Rating: ${averageRating.toStringAsFixed(1)}');
    buffer.writeln('');
    
    final rankedTeams = teamsByRating;
    for (int i = 0; i < rankedTeams.length; i++) {
      final team = rankedTeams[i];
      buffer.writeln('${i + 1}. ${team.name} (${team.abbreviation}) - ${team.averageOverallRating.toStringAsFixed(1)}');
    }
    
    return buffer.toString();
  }
}
