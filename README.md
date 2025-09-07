# Football Generator

A comprehensive Dart library for generating realistic football players, teams, and complete leagues for simulation games and sports applications.

## Features

### Player Generation
- **Realistic Player Creation**: Generate players with authentic names, physical attributes, and ratings
- **Position-Specific Logic**: Tailored generation for QB, RB, WR, TE, OL, DL, LB, CB, S, K positions
- **Diverse Backgrounds**: Players from various colleges, locations, and demographic backgrounds
- **Age-Based Variations**: Support for rookies, veterans, and players of all experience levels

### Team Generation  
- **Complete Rosters**: Generate full 53-man NFL-style rosters with proper position distribution
- **Team Identity**: Unique team names, colors, and abbreviations
- **Quality Tiers**: Five-tier system for realistic team strength variation
- **Customizable Composition**: Flexible roster structures for different league formats

### League Generation (NEW!)
- **NFL-Style Leagues**: Complete 32-team leagues with authentic AFC/NFC structure
- **Divisional Alignment**: Proper geographical divisions matching real NFL organization
- **Realistic Competition**: Teams distributed across quality tiers for balanced gameplay
- **Comprehensive Statistics**: League-wide rankings, standings, and analytics

## Getting Started

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  pocket_gm_generator: ^1.0.0
```

Then import the library:

```dart
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
```

## Usage

### Generate a Single Player

```dart
final playerGenerator = PlayerGenerator();
final player = playerGenerator.generatePlayer();

print('${player.commonName} - ${player.primaryPosition}');
print('Overall Rating: ${player.overallRating}');
print('Age: ${player.age}, Height: ${player.heightInches}", Weight: ${player.weightLbs}lbs');
```

### Generate a Team

```dart
final teamGenerator = TeamGenerator();
final team = teamGenerator.generateTeam();

print('Team: ${team.name} (${team.abbreviation})');
print('Average Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
print('Roster Size: ${team.rosterSize} players');

// View starting lineup
for (final starter in team.startingLineup) {
  print('${starter.primaryPosition}: ${starter.commonName} (${starter.overallRating})');
}
```

### Generate a Complete League

```dart
final leagueGenerator = LeagueGenerator();
final league = leagueGenerator.generateLeague(
  leagueName: "Professional Football League",
  distributeTiers: true,
  useNflStructure: true,
);

print('League: ${league.name}');
print('Teams: ${league.teamCount}');
print('Conferences: ${league.conferenceCount}');

// Display top teams
final topTeams = league.teamsByRating.take(5);
print('\nTop 5 Teams:');
for (int i = 0; i < topTeams.length; i++) {
  final team = topTeams.elementAt(i);
  print('${i + 1}. ${team.name} - ${team.averageOverallRating.toStringAsFixed(1)}');
}

// Browse by conference and division
for (final conference in league.conferences) {
  print('\n${conference.name} Conference:');
  for (final division in conference.divisions) {
    print('  ${division.name}:');
    for (final team in division.teams) {
      print('    ${team.name} (${team.abbreviation})');
    }
  }
}
```

### Advanced Usage

#### Team Quality Tiers
Generate teams with specific quality levels:

```dart
// Generate an elite team
final eliteTeam = teamGenerator.generateTeam(tier: TeamTier.superBowlContender);

// Generate a rebuilding team  
final rebuilding = teamGenerator.generateTeam(tier: TeamTier.rebuilding);

print('Elite team average: ${eliteTeam.averageOverallRating.toStringAsFixed(1)}');
print('Rebuilding team average: ${rebuilding.averageOverallRating.toStringAsFixed(1)}');
```

#### League Lookups
Find teams and divisions within a league:

```dart
final league = leagueGenerator.generateLeague();

// Find team by name
final team = league.getTeam('Buffalo Cyclones');

// Find team by abbreviation
final teamByAbbr = league.getTeamByAbbreviation('BUC');

// Find division
final afcEast = league.getDivision('AFC East');

// Get conference standings
final afcConference = league.getConference('AFC');
final afcTeams = afcConference.teamsByRating;
```

#### Custom League Structures
Create leagues with custom formats:

```dart
final customLeague = leagueGenerator.generateCustomLeague(
  leagueName: "European League",
  numberOfTeams: 24,
  numberOfConferences: 2,
  divisionsPerConference: 3,
  distributeTiers: true,
);
```

## Team Quality Distribution

When using tier distribution, teams are spread across realistic quality levels:

- **Super Bowl Contenders** (10%): 80+ overall rating
- **Playoff Teams** (25%): 75-79 overall rating  
- **Average Teams** (30%): 70-74 overall rating
- **Rebuilding Teams** (25%): 65-69 overall rating
- **Bad Teams** (10%): Under 65 overall rating

This creates natural variation where some divisions are stronger than others, just like in real football.

## Examples

### Run Example Scripts

```bash
# Generate and display a single team
dart run bin/generate_team.dart

# Generate a complete league with detailed analysis
dart run bin/generate_league.dart

# Run comprehensive test suite
dart run bin/test_league_generation.dart
```

### Sample Output

```
🏈 Generating NFL-style League 🏈

📊 League Statistics:
Teams: 32
Conferences: 2
Divisions: 8
Average Rating: 75.1
Rating Range: 65.4 - 84.8

🏆 Top 10 Teams:
1. Miami Sentinels (MIS) - 84.8
2. Chicago Angels (CHA) - 84.4
3. Indianapolis Cyclones (INC) - 81.3
...

📋 Conference Overview:
AFC Conference (Avg: 75.1):
  AFC East (Avg: 77.1)
    Buffalo Cyclones (BUC) - 76.1
    Miami Sentinels (MIS) - 84.8
    ...
```

## Documentation

- [Team Generation Guide](TEAM_GENERATION.md) - Detailed team and player generation
- [League Generation Guide](LEAGUE_GENERATION.md) - Complete league system documentation

## Performance

- **Player Generation**: ~1ms per player
- **Team Generation**: ~50ms per team (53 players)
- **League Generation**: ~150ms for complete 32-team league
- **Memory Efficient**: No persistent state or heavy allocations

## Testing

Run the test suites to validate functionality:

```bash
# Test team tier system
dart run bin/test_team_tiers.dart

# Test league generation
dart run bin/test_league_generation.dart

# Test rating distributions  
dart run bin/test_ratings.dart
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Roadmap

Future enhancements planned:
- Season scheduling system
- Playoff bracket generation
- Player progression and aging
- Draft simulation
- Trade mechanics
- Salary cap management
- Coaching staff generation
- Stadium and market data
