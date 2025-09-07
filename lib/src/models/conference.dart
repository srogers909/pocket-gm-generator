import 'division.dart';
import 'team.dart';

/// Represents a conference in the league containing 4 divisions
class Conference {
  final String name;
  final String abbreviation;
  final List<Division> divisions;

  Conference({
    required this.name,
    required this.abbreviation,
    required this.divisions,
  });

  /// Gets the number of divisions in the conference
  int get divisionCount => divisions.length;

  /// Gets the total number of teams in the conference
  int get teamCount => divisions.fold<int>(0, (sum, division) => sum + division.teamCount);

  /// Gets all teams in the conference
  List<Team> get allTeams {
    final teams = <Team>[];
    for (final division in divisions) {
      teams.addAll(division.teams);
    }
    return teams;
  }

  /// Gets the average rating of all teams in the conference
  double get averageRating {
    final teams = allTeams;
    if (teams.isEmpty) return 0.0;
    final totalRating = teams.fold<double>(0.0, (sum, team) => sum + team.averageOverallRating);
    return totalRating / teams.length;
  }

  /// Gets teams sorted by average rating (best to worst)
  List<Team> get teamsByRating {
    final teams = allTeams;
    teams.sort((a, b) => b.averageOverallRating.compareTo(a.averageOverallRating));
    return teams;
  }

  /// Gets division by name
  Division? getDivision(String divisionName) {
    try {
      return divisions.firstWhere((division) => division.name == divisionName);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('=== $name Conference ===');
    buffer.writeln('Divisions: $divisionCount');
    buffer.writeln('Teams: $teamCount');
    buffer.writeln('Average Rating: ${averageRating.toStringAsFixed(1)}');
    buffer.writeln('');
    
    for (final division in divisions) {
      buffer.writeln(division.toString());
      buffer.writeln('');
    }
    
    return buffer.toString();
  }

  /// Returns a summary of conference standings
  String get standings {
    final buffer = StringBuffer();
    buffer.writeln('=== $name Conference Standings ===');
    
    final rankedTeams = teamsByRating;
    for (int i = 0; i < rankedTeams.length; i++) {
      final team = rankedTeams[i];
      // Find which division this team belongs to
      final teamDivision = divisions.firstWhere((division) => division.teams.contains(team));
      buffer.writeln('${i + 1}. ${team.name} (${team.abbreviation}) - ${teamDivision.name} - ${team.averageOverallRating.toStringAsFixed(1)}');
    }
    
    return buffer.toString();
  }
}
