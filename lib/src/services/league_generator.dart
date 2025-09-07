import 'dart:math';
import '../models/league.dart';
import '../models/conference.dart';
import '../models/division.dart';
import '../models/team.dart';
import '../models/team_tier.dart';
import '../data/nfl_structure.dart';
import '../data/team_names.dart';
import 'team_generator.dart';
import 'referee_generator.dart';

/// Service for generating complete NFL-style leagues
class LeagueGenerator {
  final Random _random = Random();
  final TeamGenerator _teamGenerator = TeamGenerator();

  /// Generates a complete NFL-style league with 32 teams, 2 conferences, and 8 divisions
  /// [leagueName] - Name of the league (default: "National Football League")
  /// [distributeTiers] - Whether to distribute teams across different quality tiers (default: true)
  /// [useNflStructure] - Whether to use exact NFL division structure (default: true)
  League generateLeague({
    String leagueName = "National Football League",
    bool distributeTiers = true,
    bool useNflStructure = true,
  }) {
    // Validate NFL structure
    if (useNflStructure && !isValidNflStructure) {
      throw StateError('Invalid NFL structure: Expected 32 teams in 2 conferences with 4 divisions each');
    }

    final conferences = <Conference>[];
    final usedTeamNames = <String>{};

    // Generate conferences
    for (final conferenceName in conferenceNames) {
      final divisions = <Division>[];

      // Generate divisions for this conference
      for (final divisionName in getDivisionNames(conferenceName)) {
        final divisionTeams = <Team>[];
        final cities = getDivisionCities(conferenceName, divisionName);

        // Generate teams for this division
        for (final city in cities) {
          final team = _generateTeamForCity(
            city: city,
            conference: conferenceName,
            division: divisionName,
            usedNames: usedTeamNames,
            distributeTiers: distributeTiers,
          );
          divisionTeams.add(team);
        }

        // Create division
        final division = Division(
          name: divisionName,
          teams: divisionTeams,
        );
        divisions.add(division);
      }

      // Create conference
      final conference = Conference(
        name: getConferenceFullName(conferenceName),
        abbreviation: getConferenceAbbreviation(conferenceName),
        divisions: divisions,
      );
      conferences.add(conference);
    }

    // Generate referee pool for the league
    final refereePool = RefereeGenerator.generateRefereePool();

    return League(
      name: leagueName,
      conferences: conferences,
      refereePool: refereePool,
    );
  }

  /// Generates a team for a specific city with league constraints
  Team _generateTeamForCity({
    required String city,
    required String conference,
    required String division,
    required Set<String> usedNames,
    required bool distributeTiers,
  }) {
    Team team;
    String teamName;
    int attempts = 0;
    const maxAttempts = 100;

    // Determine team tier for variation
    TeamTier? tier;
    if (distributeTiers) {
      tier = _assignRandomTier();
    }

    // Keep generating until we get a unique team name
    do {
      // Select a random team name
      final nameIndex = _random.nextInt(teamNames.length);
      final selectedName = teamNames[nameIndex];
      teamName = '$city $selectedName';
      
      attempts++;
      if (attempts > maxAttempts) {
        // If we can't find a unique name, use a numbered variant
        teamName = '$city ${selectedName}_$attempts';
        break;
      }
    } while (usedNames.contains(teamName));

    usedNames.add(teamName);

    // Generate the team with specific parameters
    team = _teamGenerator.generateTeam(tier: tier);
    
    // Create a new team with the correct identity and league information
    return Team(
      name: teamName,
      abbreviation: _generateAbbreviation(city, teamName.split(' ').last),
      primaryColor: team.primaryColor,
      secondaryColor: team.secondaryColor,
      roster: team.roster,
      stadium: team.stadium,
      fanHappiness: team.fanHappiness,
      staff: team.staff,
      conference: conference,
      division: division,
      city: city,
      tier: tier,
    );
  }

  /// Generates a team abbreviation based on city and team name
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

  /// Generates a league with custom structure (for non-NFL formats)
  League generateCustomLeague({
    required String leagueName,
    required int numberOfTeams,
    required int numberOfConferences,
    required int divisionsPerConference,
    bool distributeTiers = true,
  }) {
    // Validate inputs
    final expectedTeams = numberOfConferences * divisionsPerConference * 4;
    if (numberOfTeams != expectedTeams) {
      throw ArgumentError('Number of teams ($numberOfTeams) must equal conferences ($numberOfConferences) × divisions per conference ($divisionsPerConference) × 4');
    }

    final conferences = <Conference>[];
    final usedTeamNames = <String>{};

    for (int c = 0; c < numberOfConferences; c++) {
      final divisions = <Division>[];
      
      for (int d = 0; d < divisionsPerConference; d++) {
        final divisionTeams = <Team>[];
        
        for (int t = 0; t < 4; t++) {
          final team = _generateRandomTeam(
            usedNames: usedTeamNames,
            distributeTiers: distributeTiers,
          );
          divisionTeams.add(team);
        }
        
        final division = Division(
          name: 'Conference ${c + 1} Division ${d + 1}',
          teams: divisionTeams,
        );
        divisions.add(division);
      }
      
      final conference = Conference(
        name: 'Conference ${c + 1}',
        abbreviation: 'C${c + 1}',
        divisions: divisions,
      );
      conferences.add(conference);
    }

    // Generate referee pool for the custom league
    final refereePool = RefereeGenerator.generateRefereePool();

    return League(
      name: leagueName,
      conferences: conferences,
      refereePool: refereePool,
    );
  }

  /// Generates a random team for custom leagues
  Team _generateRandomTeam({
    required Set<String> usedNames,
    required bool distributeTiers,
  }) {
    Team team;
    String teamName;
    int attempts = 0;
    const maxAttempts = 100;

    // Determine team tier for variation
    TeamTier? tier;
    if (distributeTiers) {
      tier = _assignRandomTier();
    }

    // Generate a team with random city and name
    do {
      team = _teamGenerator.generateTeam(tier: tier);
      teamName = team.name;
      
      attempts++;
      if (attempts > maxAttempts) {
        // If we can't find a unique name, modify it
        teamName = '${team.name}_$attempts';
        break;
      }
    } while (usedNames.contains(teamName));

    usedNames.add(teamName);

    // Return team with potentially modified name
    if (teamName != team.name) {
      return Team(
        name: teamName,
        abbreviation: team.abbreviation,
        primaryColor: team.primaryColor,
        secondaryColor: team.secondaryColor,
        roster: team.roster,
        stadium: team.stadium,
        fanHappiness: team.fanHappiness,
        staff: team.staff,
        conference: null,
        division: null,
        city: null,
      );
    }

    return team;
  }
}
