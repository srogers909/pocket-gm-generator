import 'dart:math';
import '../models/team.dart';
import '../models/player.dart';
import '../models/team_tier.dart';
import '../data/cities.dart';
import '../data/team_names.dart';
import 'player_generator.dart';
import 'staff_generator.dart';
import 'stadium_generator.dart';

/// Service for generating realistic football teams
class TeamGenerator {
  final Random _random = Random();
  final PlayerGenerator _playerGenerator = PlayerGenerator();
  final StaffGenerator _staffGenerator = StaffGenerator();
  final StadiumGenerator _stadiumGenerator = StadiumGenerator();

  /// List of common team colors
  static const List<String> teamColors = [
    'Red',
    'Blue',
    'Green',
    'Black',
    'White',
    'Navy',
    'Purple',
    'Orange',
    'Gold',
    'Silver',
    'Maroon',
    'Teal',
    'Crimson',
    'Royal Blue',
    'Forest Green',
    'Steel Gray',
    'Burgundy',
    'Bronze',
    'Copper',
    'Midnight Blue',
    'Emerald',
    'Scarlet',
    'Indigo',
    'Turquoise',
    'Lime',
    'Magenta',
    'Cyan',
    'Yellow',
    'Pink',
    'Brown',
  ];

  /// Roster composition for a 53-man NFL roster
  static const Map<String, int> rosterComposition = {
    'QB': 3,   // Quarterbacks
    'RB': 4,   // Running Backs
    'WR': 6,   // Wide Receivers
    'TE': 3,   // Tight Ends
    'OL': 9,   // Offensive Line (includes long snapper)
    'DL': 8,   // Defensive Line
    'LB': 7,   // Linebackers
    'CB': 6,   // Cornerbacks
    'S': 5,    // Safeties
    'K': 2,    // Kickers (includes punting duties)
  };

  /// Generates a complete football team with a 53-man roster
  /// [tier] - Optional team tier to determine player quality distribution
  Team generateTeam({TeamTier? tier}) {
    // Generate team identity
    final city = nflCities[_random.nextInt(nflCities.length)];
    final teamName = teamNames[_random.nextInt(teamNames.length)];
    final fullName = '$city $teamName';
    
    // Generate abbreviation (first letter of city + first two letters of team name)
    final abbreviation = _generateAbbreviation(city, teamName);
    
    // Generate team colors
    final primaryColor = teamColors[_random.nextInt(teamColors.length)];
    String secondaryColor;
    do {
      secondaryColor = teamColors[_random.nextInt(teamColors.length)];
    } while (secondaryColor == primaryColor);

    // Generate roster with tier-based player quality
    final roster = _generateRoster(tier: tier);
    
    // Generate staff with tier-based quality
    final staff = _staffGenerator.generateTeamStaff(tier ?? TeamTier.average);
    
    // Generate stadium
    final stadium = _stadiumGenerator.generateStadium();
    
    // Calculate fan happiness based on team's overall rating
    final teamRating = roster.fold<int>(0, (sum, player) => sum + player.overallRating) / roster.length;
    final fanHappiness = _generateFanHappiness(teamRating);

    // Generate realistic win-loss record based on team tier and quality
    final (wins, losses) = _generateWinLossRecord(tier, teamRating);

    return Team(
      name: fullName,
      abbreviation: abbreviation,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      roster: roster,
      stadium: stadium,
      fanHappiness: fanHappiness,
      wins: wins,
      losses: losses,
      staff: staff,
    );
  }

  /// Generates a team abbreviation
  String _generateAbbreviation(String city, String teamName) {
    // Handle special cases for cities with multiple words
    String cityPrefix;
    if (city.contains(' ')) {
      // For multi-word cities, take first letter of each word
      final words = city.split(' ');
      if (words.length == 2) {
        cityPrefix = words[0].substring(0, 1) + words[1].substring(0, 1);
      } else {
        cityPrefix = words[0].substring(0, 1) + words[1].substring(0, 1);
      }
    } else {
      // For single word cities, take first two letters
      cityPrefix = city.length >= 2 ? city.substring(0, 2) : city.substring(0, 1);
    }
    
    // Take first letter of team name
    final teamPrefix = teamName.substring(0, 1);
    
    return (cityPrefix + teamPrefix).toUpperCase();
  }

  /// Generates a complete 53-man roster
  /// [tier] - Optional team tier to determine player quality distribution
  List<Player> _generateRoster({TeamTier? tier}) {
    final roster = <Player>[];
    
    // Generate players for each position according to roster composition
    rosterComposition.forEach((position, count) {
      for (int i = 0; i < count; i++) {
        final player = _generatePlayerForPosition(position, tier: tier);
        roster.add(player);
      }
    });
    
    // Verify we have exactly 53 players
    assert(roster.length == 53, 'Roster should have exactly 53 players, but has ${roster.length}');
    
    return roster;
  }

  /// Generates a player for a specific position
  /// [tier] - Optional team tier to determine player quality distribution
  Player _generatePlayerForPosition(String position, {TeamTier? tier}) {
    Player player;
    
    // Keep generating until we get a player with the desired position
    do {
      player = _playerGenerator.generatePlayer(tier: tier);
    } while (player.primaryPosition != position);
    
    return player;
  }

  /// Generates multiple teams for a league with varied team tiers
  /// [numberOfTeams] - Number of teams to generate
  /// [distributeTiers] - Whether to distribute teams across different tiers (default: true)
  List<Team> generateLeague(int numberOfTeams, {bool distributeTiers = true}) {
    final teams = <Team>[];
    final usedCombinations = <String>{};
    
    for (int i = 0; i < numberOfTeams; i++) {
      Team team;
      String combination;
      
      // Determine team tier for variation
      TeamTier? tier;
      if (distributeTiers) {
        tier = _assignRandomTier();
      }
      
      // Ensure unique team names within the league
      do {
        team = generateTeam(tier: tier);
        combination = team.name;
      } while (usedCombinations.contains(combination) && usedCombinations.length < (nflCities.length * teamNames.length));
      
      usedCombinations.add(combination);
      teams.add(team);
    }
    
    return teams;
  }

  /// Assigns a random team tier with realistic distribution
  TeamTier _assignRandomTier() {
    final roll = _random.nextInt(100);
    
    // Realistic distribution:
    // 10% Super Bowl Contenders
    // 25% Playoff Teams  
    // 30% Average Teams
    // 25% Rebuilding Teams
    // 10% Bad Teams
    if (roll < 10) return TeamTier.superBowlContender;
    if (roll < 35) return TeamTier.playoffTeam;
    if (roll < 65) return TeamTier.average;
    if (roll < 90) return TeamTier.rebuilding;
    return TeamTier.bad;
  }

  /// Generates a team with veteran players (for rebuilding/established teams)
  Team generateVeteranTeam({int? averageAge}) {
    // Generate team identity same as regular team
    final city = nflCities[_random.nextInt(nflCities.length)];
    final teamName = teamNames[_random.nextInt(teamNames.length)];
    final fullName = '$city $teamName';
    final abbreviation = _generateAbbreviation(city, teamName);
    
    final primaryColor = teamColors[_random.nextInt(teamColors.length)];
    String secondaryColor;
    do {
      secondaryColor = teamColors[_random.nextInt(teamColors.length)];
    } while (secondaryColor == primaryColor);

    // Generate veteran roster
    final roster = _generateVeteranRoster(averageAge: averageAge);
    
    // Generate average-tier staff for veteran teams
    final staff = _staffGenerator.generateTeamStaff(TeamTier.average);
    
    // Generate stadium
    final stadium = _stadiumGenerator.generateStadium();
    
    // Calculate fan happiness based on team's overall rating
    final teamRating = roster.fold<int>(0, (sum, player) => sum + player.overallRating) / roster.length;
    final fanHappiness = _generateFanHappiness(teamRating);

    // Generate realistic win-loss record for veteran teams (typically average tier)
    final (wins, losses) = _generateWinLossRecord(TeamTier.average, teamRating);

    return Team(
      name: fullName,
      abbreviation: abbreviation,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      roster: roster,
      stadium: stadium,
      fanHappiness: fanHappiness,
      wins: wins,
      losses: losses,
      staff: staff,
    );
  }

  /// Generates a roster with veteran players
  List<Player> _generateVeteranRoster({int? averageAge}) {
    final roster = <Player>[];
    
    rosterComposition.forEach((position, count) {
      for (int i = 0; i < count; i++) {
        final player = _generateVeteranPlayerForPosition(position, averageAge: averageAge);
        roster.add(player);
      }
    });
    
    return roster;
  }

  /// Generates a veteran player for a specific position
  Player _generateVeteranPlayerForPosition(String position, {int? averageAge}) {
    Player player;
    
    do {
      // Generate age range for veterans (23-35)
      final age = averageAge ?? (23 + _random.nextInt(13));
      player = _playerGenerator.generateVeteranPlayer(age: age);
    } while (player.primaryPosition != position);
    
    return player;
  }

  /// Generates fan happiness based on team's overall rating
  /// Returns value between 50-100, heavily influenced by team rating
  int _generateFanHappiness(double teamRating) {
    // Base fan happiness on team rating with some randomization
    int baseFanHappiness;
    
    if (teamRating >= 85.0) {
      // Elite teams: 90-100 fan happiness
      baseFanHappiness = 90 + _random.nextInt(11);
    } else if (teamRating >= 80.0) {
      // Strong teams: 80-95 fan happiness
      baseFanHappiness = 80 + _random.nextInt(16);
    } else if (teamRating >= 76.0) {
      // Average teams: 70-85 fan happiness
      baseFanHappiness = 70 + _random.nextInt(16);
    } else if (teamRating >= 71.0) {
      // Rebuilding teams: 60-75 fan happiness
      baseFanHappiness = 60 + _random.nextInt(16);
    } else {
      // Poor teams: 50-65 fan happiness
      baseFanHappiness = 50 + _random.nextInt(16);
    }
    
    // Ensure it stays within 50-100 range
    return max(50, min(100, baseFanHappiness));
  }

  /// Generates realistic win-loss record based on team tier and overall rating
  /// Returns a record for a typical 17-game NFL season
  (int wins, int losses) _generateWinLossRecord(TeamTier? tier, double teamRating) {
    // Determine base win expectation based on team tier and rating
    int baseWins;
    
    // Primary factor: team tier
    switch (tier) {
      case TeamTier.superBowlContender:
        baseWins = 13 + _random.nextInt(3); // 13-15 wins
        break;
      case TeamTier.playoffTeam:
        baseWins = 10 + _random.nextInt(3); // 10-12 wins
        break;
      case TeamTier.average:
        baseWins = 7 + _random.nextInt(4); // 7-10 wins
        break;
      case TeamTier.rebuilding:
        baseWins = 4 + _random.nextInt(4); // 4-7 wins
        break;
      case TeamTier.bad:
        baseWins = 1 + _random.nextInt(4); // 1-4 wins
        break;
      case null:
        // If no tier specified, use team rating
        if (teamRating >= 85.0) {
          baseWins = 12 + _random.nextInt(4); // 12-15 wins
        } else if (teamRating >= 80.0) {
          baseWins = 9 + _random.nextInt(4); // 9-12 wins
        } else if (teamRating >= 76.0) {
          baseWins = 7 + _random.nextInt(4); // 7-10 wins
        } else if (teamRating >= 71.0) {
          baseWins = 5 + _random.nextInt(4); // 5-8 wins
        } else {
          baseWins = 2 + _random.nextInt(4); // 2-5 wins
        }
        break;
    }
    
    // Secondary adjustment based on team rating (fine-tuning)
    if (teamRating >= 85.0 && baseWins < 12) {
      baseWins += 1; // Elite talent should have good records
    } else if (teamRating < 71.0 && baseWins > 6) {
      baseWins -= 1; // Poor talent should struggle
    }
    
    // Ensure wins stay within realistic bounds (0-17)
    final wins = max(0, min(17, baseWins));
    final losses = 17 - wins;
    
    return (wins, losses);
  }
}
