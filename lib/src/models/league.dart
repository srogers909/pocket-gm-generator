import 'conference.dart';
import 'division.dart';
import 'team.dart';
import 'referee.dart';

/// Represents a complete league with two conferences and eight divisions
class League {
  final String name;
  final List<Conference> conferences;
  final List<Referee> refereePool;

  League({
    required this.name,
    required this.conferences,
    required this.refereePool,
  });

  /// Gets the number of conferences in the league
  int get conferenceCount => conferences.length;

  /// Gets the total number of divisions in the league
  int get divisionCount => conferences.fold<int>(0, (sum, conference) => sum + conference.divisionCount);

  /// Gets the total number of teams in the league
  int get teamCount => conferences.fold<int>(0, (sum, conference) => sum + conference.teamCount);

  /// Gets all teams in the league
  List<Team> get allTeams {
    final teams = <Team>[];
    for (final conference in conferences) {
      teams.addAll(conference.allTeams);
    }
    return teams;
  }

  /// Gets the average rating of all teams in the league
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

  /// Gets conference by name
  Conference? getConference(String conferenceName) {
    try {
      return conferences.firstWhere((conference) => conference.name == conferenceName);
    } catch (e) {
      return null;
    }
  }

  /// Gets division by name (searches all conferences)
  Division? getDivision(String divisionName) {
    for (final conference in conferences) {
      final division = conference.getDivision(divisionName);
      if (division != null) return division;
    }
    return null;
  }

  /// Gets team by name (searches all conferences and divisions)
  Team? getTeam(String teamName) {
    final teams = allTeams;
    try {
      return teams.firstWhere((team) => team.name == teamName);
    } catch (e) {
      return null;
    }
  }

  /// Gets team by abbreviation (searches all conferences and divisions)
  Team? getTeamByAbbreviation(String abbreviation) {
    final teams = allTeams;
    try {
      return teams.firstWhere((team) => team.abbreviation == abbreviation);
    } catch (e) {
      return null;
    }
  }

  /// Gets league statistics
  Map<String, dynamic> get statistics {
    final teams = allTeams;
    if (teams.isEmpty) {
      return {
        'totalTeams': 0,
        'averageRating': 0.0,
        'highestRating': 0.0,
        'lowestRating': 0.0,
        'ratingRange': 0.0,
      };
    }

    final ratings = teams.map((team) => team.averageOverallRating).toList();
    ratings.sort();

    return {
      'totalTeams': teams.length,
      'averageRating': averageRating,
      'highestRating': ratings.last,
      'lowestRating': ratings.first,
      'ratingRange': ratings.last - ratings.first,
    };
  }

  /// Converts the League to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'conferences': conferences.map((conference) => conference.toJson()).toList(),
      'refereePool': refereePool.map((referee) => referee.toJson()).toList(),
      // Computed properties
      'conferenceCount': conferenceCount,
      'divisionCount': divisionCount,
      'teamCount': teamCount,
      'averageRating': averageRating,
      'statistics': statistics,
    };
  }

  /// Creates a League from a JSON representation
  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      name: json['name'] as String,
      conferences: (json['conferences'] as List<dynamic>)
          .map((conferenceJson) => Conference.fromJson(conferenceJson as Map<String, dynamic>))
          .toList(),
      refereePool: (json['refereePool'] as List<dynamic>)
          .map((refereeJson) => Referee.fromJson(refereeJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('=== $name ===');
    buffer.writeln('Conferences: $conferenceCount');
    buffer.writeln('Divisions: $divisionCount');
    buffer.writeln('Teams: $teamCount');
    buffer.writeln('Average Rating: ${averageRating.toStringAsFixed(1)}');
    
    final stats = statistics;
    buffer.writeln('Rating Range: ${stats['lowestRating'].toStringAsFixed(1)} - ${stats['highestRating'].toStringAsFixed(1)} (${stats['ratingRange'].toStringAsFixed(1)} points)');
    buffer.writeln('');
    
    for (final conference in conferences) {
      buffer.writeln(conference.toString());
      buffer.writeln('');
    }
    
    return buffer.toString();
  }

  /// Returns a summary of league standings
  String get standings {
    final buffer = StringBuffer();
    buffer.writeln('=== $name League Standings ===');
    buffer.writeln('');
    
    for (final conference in conferences) {
      buffer.writeln(conference.standings);
      buffer.writeln('');
    }
    
    return buffer.toString();
  }

  /// Returns power rankings of all teams
  String get powerRankings {
    final buffer = StringBuffer();
    buffer.writeln('=== $name Power Rankings ===');
    
    final rankedTeams = teamsByRating;
    for (int i = 0; i < rankedTeams.length; i++) {
      final team = rankedTeams[i];
      
      // Find which conference and division this team belongs to
      Conference? teamConference;
      Division? teamDivision;
      
      for (final conference in conferences) {
        for (final division in conference.divisions) {
          if (division.teams.contains(team)) {
            teamConference = conference;
            teamDivision = division;
            break;
          }
        }
        if (teamConference != null) break;
      }
      
      buffer.writeln('${i + 1}. ${team.name} (${team.abbreviation}) - ${teamConference?.name} ${teamDivision?.name} - ${team.averageOverallRating.toStringAsFixed(1)}');
    }
    
    return buffer.toString();
  }
}
