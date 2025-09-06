# Team Generation System

## Overview

The team generation system creates realistic football teams with complete 53-man rosters, following NFL standards with consolidated positions as requested.

## Features

### 🏈 Team Identity Generation
- **Team Names**: Combines NFL cities with creative team names from a library of 200+ fictional options (no real professional team names)
- **Abbreviations**: Smart 2-3 character abbreviations (e.g., "New York Grizzlies" → "NYG")
- **Team Colors**: Primary and secondary colors automatically selected (never the same)

### 👥 Roster Composition (53 Players Total)
- **QB**: 3 Quarterbacks
- **RB**: 4 Running Backs  
- **WR**: 6 Wide Receivers
- **TE**: 3 Tight Ends
- **OL**: 9 Offensive Line (includes Long Snapper as requested)
- **DL**: 8 Defensive Line
- **LB**: 7 Linebackers
- **CB**: 6 Cornerbacks
- **S**: 5 Safeties
- **K**: 2 Kickers (includes Punting duties as requested)

### ⭐ Team Features
- **Starting Lineup**: Best player at each position automatically selected
- **Team Statistics**: Average overall rating calculated across roster
- **Roster Management**: Players organized by position with easy access methods
- **Veteran Teams**: Option to generate teams with older, more experienced players

## Quick Start

```dart
import 'package:pocket_gm_generator/pocket_gm_generator.dart';

// Create team generator
final teamGenerator = TeamGenerator();

// Generate a single team
final team = teamGenerator.generateTeam();
print('${team.name} (${team.abbreviation})');
print('Roster: ${team.roster.length} players');
print('Average Rating: ${team.averageOverallRating.toStringAsFixed(1)}');

// Generate multiple teams for a league
final teams = teamGenerator.generateLeague(8);

// Generate a veteran team
final veteranTeam = teamGenerator.generateVeteranTeam();
```

## API Reference

### TeamGenerator Class

#### Methods
- `generateTeam()` → `Team`: Creates a new team with random identity and roster
- `generateLeague(int numberOfTeams)` → `List<Team>`: Creates multiple unique teams
- `generateVeteranTeam({int? averageAge})` → `Team`: Creates team with veteran players

### Team Class

#### Properties
- `name` → `String`: Full team name (e.g., "Dallas Cowboys")
- `abbreviation` → `String`: Team abbreviation (e.g., "DAL")
- `primaryColor` → `String`: Primary team color
- `secondaryColor` → `String`: Secondary team color
- `roster` → `List<Player>`: Complete 53-man roster
- `rosterSize` → `int`: Number of players on roster (always 53)
- `averageOverallRating` → `double`: Team's average player rating
- `startingLineup` → `List<Player>`: Best player at each position
- `rosterBreakdown` → `Map<String, int>`: Player count by position

#### Methods
- `getPlayersByPosition(String position)` → `List<Player>`: Get all players at a position
- `toString()` → `String`: Comprehensive team summary
- `detailedRoster` → `String`: Complete roster with all player details

## Examples

### Generate and Display Team Info
```dart
final team = teamGenerator.generateTeam();

print('=== ${team.name} ===');
print('Colors: ${team.primaryColor} / ${team.secondaryColor}');
print('Average Rating: ${team.averageOverallRating.toStringAsFixed(1)}');

// Show starting lineup
print('\nStarting Lineup:');
for (final player in team.startingLineup) {
  print('${player.primaryPosition}: ${player.commonName} (${player.overallRating})');
}

// Show roster composition
print('\nRoster Breakdown:');
final breakdown = team.rosterBreakdown;
breakdown.forEach((position, count) {
  print('$position: $count players');
});
```

### Generate League
```dart
final teams = teamGenerator.generateLeague(4);

print('=== LEAGUE TEAMS ===');
for (int i = 0; i < teams.length; i++) {
  final team = teams[i];
  final qb = team.getPlayersByPosition('QB').first;
  print('${i + 1}. ${team.name} (${team.abbreviation})');
  print('   QB: ${qb.commonName} (${qb.overallRating})');
  print('   Team Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
}
```

## Testing

Run the comprehensive test suite:
```bash
dart test test/team_generator_test.dart
```

Tests cover:
- ✅ Valid team generation with 53-man rosters
- ✅ Correct roster composition by position
- ✅ Starting lineup selection (best players)
- ✅ Unique team generation for leagues
- ✅ Veteran team generation
- ✅ Team abbreviation logic
- ✅ Comprehensive string representations

## Demo

Run the interactive demo:
```bash
dart run bin/generate_team.dart
```

This demonstrates:
- Single team generation with full details
- Multiple team comparison
- Veteran team showcase
- Roster composition validation

## Integration Notes

- Consolidates Punter/Kicker into single "K" position as requested
- Consolidates Long Snapper into Offensive Line (OL) as requested
- Uses existing Player model and PlayerGenerator for realistic player data
- Follows NFL roster composition standards adapted for 53-man rosters
- Exports cleanly through main library file for easy integration
