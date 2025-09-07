# League Generation Documentation

This document describes the league generation functionality in the Football Generator library.

## Overview

The league generation system allows you to create complete football leagues that mirror the NFL structure, including:

- 32 teams organized into 2 conferences and 8 divisions
- Realistic team quality distribution using the tier system
- Proper divisional alignment based on actual NFL geography
- Comprehensive league statistics and rankings

## Quick Start

```dart
import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  // Create a league generator
  final leagueGenerator = LeagueGenerator();
  
  // Generate a complete NFL-style league
  final league = leagueGenerator.generateLeague();
  
  // Display league information
  print('League: ${league.name}');
  print('Teams: ${league.teamCount}');
  print('Average Rating: ${league.averageRating.toStringAsFixed(1)}');
  
  // Get power rankings
  final topTeams = league.teamsByRating.take(5);
  print('\nTop 5 Teams:');
  for (int i = 0; i < topTeams.length; i++) {
    final team = topTeams.elementAt(i);
    print('${i + 1}. ${team.name} - ${team.averageOverallRating.toStringAsFixed(1)}');
  }
}
```

## Core Models

### League
Represents the complete league structure with conferences and divisions.

**Properties:**
- `name`: League name
- `conferences`: List of Conference objects
- `teamCount`: Total number of teams
- `averageRating`: Average rating across all teams
- `statistics`: Detailed league statistics

**Methods:**
- `getConference(name)`: Find conference by name
- `getDivision(name)`: Find division by name  
- `getTeam(name)`: Find team by name
- `getTeamByAbbreviation(abbr)`: Find team by abbreviation
- `teamsByRating`: Teams sorted by rating (best to worst)

### Conference
Represents a conference (AFC/NFC) containing 4 divisions.

**Properties:**
- `name`: Conference name
- `divisions`: List of Division objects
- `teamCount`: Number of teams in conference
- `averageRating`: Average rating of conference teams

### Division
Represents a division containing 4 teams.

**Properties:**
- `name`: Division name (e.g., "AFC East")
- `teams`: List of Team objects
- `averageRating`: Average rating of division teams

### Team (Enhanced)
The Team model has been enhanced with league information:

**New Properties:**
- `conference`: Conference name (AFC/NFC)
- `division`: Division name (e.g., "AFC East")
- `city`: Team's city

## League Generator

### Basic Generation

```dart
final leagueGenerator = LeagueGenerator();

// Generate with default settings
final league = leagueGenerator.generateLeague();

// Generate with custom settings
final customLeague = leagueGenerator.generateLeague(
  leagueName: "My Football League",
  distributeTiers: true,
  useNflStructure: true,
);
```

### Parameters

- `leagueName`: Name of the league (default: "National Football League")
- `distributeTiers`: Whether to vary team quality using tiers (default: true)
- `useNflStructure`: Whether to use exact NFL divisions (default: true)

### Custom Leagues

You can also generate leagues with custom structures:

```dart
final customLeague = leagueGenerator.generateCustomLeague(
  leagueName: "Custom League",
  numberOfTeams: 24,
  numberOfConferences: 2,
  divisionsPerConference: 3,
  distributeTiers: true,
);
```

## NFL Structure

The system uses the exact NFL divisional structure:

### AFC Conference
- **AFC East**: Buffalo, Miami, New England, New York
- **AFC North**: Baltimore, Cincinnati, Cleveland, Pittsburgh  
- **AFC South**: Houston, Indianapolis, Jacksonville, Tennessee
- **AFC West**: Denver, Kansas City, Las Vegas, Los Angeles

### NFC Conference
- **NFC East**: Dallas, New York, Philadelphia, Washington
- **NFC North**: Chicago, Detroit, Green Bay, Minnesota
- **NFC South**: Atlanta, Carolina, New Orleans, Tampa Bay
- **NFC West**: Arizona, Los Angeles, San Francisco, Seattle

## Team Quality Distribution

When `distributeTiers` is enabled, teams are distributed across quality tiers:

- **Super Bowl Contenders** (10%): Elite teams (80+ rating)
- **Playoff Teams** (25%): Strong teams (75-79 rating)
- **Average Teams** (30%): Middle-tier teams (70-74 rating)
- **Rebuilding Teams** (25%): Developing teams (65-69 rating)
- **Bad Teams** (10%): Struggling teams (60-64 rating)

This creates realistic variation where some divisions are stronger than others.

## Usage Examples

### Display Conference Standings

```dart
final league = leagueGenerator.generateLeague();

for (final conference in league.conferences) {
  print('\n${conference.name} Conference:');
  final teams = conference.teamsByRating;
  for (int i = 0; i < teams.length; i++) {
    final team = teams[i];
    print('${i + 1}. ${team.name} - ${team.averageOverallRating.toStringAsFixed(1)}');
  }
}
```

### Analyze Division Strength

```dart
final league = leagueGenerator.generateLeague();

for (final conference in league.conferences) {
  for (final division in conference.divisions) {
    print('${division.name}: ${division.averageRating.toStringAsFixed(1)} avg');
  }
}
```

### Find Specific Teams

```dart
final league = leagueGenerator.generateLeague();

// Find by name
final team = league.getTeam('Buffalo Surge');

// Find by abbreviation  
final teamByAbbr = league.getTeamByAbbreviation('BUS');

// Find division
final division = league.getDivision('AFC East');
```

### League Statistics

```dart
final league = leagueGenerator.generateLeague();
final stats = league.statistics;

print('Total Teams: ${stats['totalTeams']}');
print('Average Rating: ${stats['averageRating'].toStringAsFixed(1)}');
print('Rating Range: ${stats['lowestRating'].toStringAsFixed(1)} - ${stats['highestRating'].toStringAsFixed(1)}');
print('Variation: ${stats['ratingRange'].toStringAsFixed(1)} points');
```

## Testing

Run the comprehensive test suite:

```bash
cd generator
dart run bin/test_league_generation.dart
```

This will validate:
- Correct league structure (32 teams, 2 conferences, 8 divisions)
- Proper team distribution across divisions
- Rating variation and tier distribution
- Lookup functionality
- Performance benchmarks

## Integration with Existing Code

The league generation system is fully compatible with existing team and player generation:

```dart
// Generate individual team (still works)
final teamGenerator = TeamGenerator();
final singleTeam = teamGenerator.generateTeam();

// Generate complete league (new functionality)
final leagueGenerator = LeagueGenerator();
final league = leagueGenerator.generateLeague();

// All teams in the league have full rosters
for (final team in league.allTeams) {
  print('${team.name}: ${team.rosterSize} players');
}
```

## Performance

League generation is optimized for performance:
- Typical generation time: 100-200ms for 32 teams
- Each team has a complete 53-player roster
- No blocking operations or heavy computations

## Future Enhancements

The league structure provides a foundation for future features:
- Season scheduling
- Playoff brackets
- Draft systems
- Trade mechanics
- Statistical tracking
