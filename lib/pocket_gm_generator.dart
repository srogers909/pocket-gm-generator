/// Support for generating realistic football players, teams, and game data.
///
/// This library provides tools for creating authentic-sounding players with
/// realistic attributes, names, and backgrounds, as well as complete teams
/// with proper roster composition for football simulation games.
library;

export 'src/models/player.dart';
export 'src/models/team.dart';
export 'src/models/team_tier.dart';
export 'src/models/staff.dart';
export 'src/models/stadium.dart';
export 'src/models/division.dart';
export 'src/models/conference.dart';
export 'src/models/league.dart';
export 'src/models/referee.dart';
export 'src/services/player_generator.dart';
export 'src/services/team_generator.dart';
export 'src/services/staff_generator.dart';
export 'src/services/stadium_generator.dart';
export 'src/services/league_generator.dart';
export 'src/services/referee_generator.dart';

// Data exports (optional, for advanced usage)
export 'src/data/names.dart';
export 'src/data/schools.dart';
export 'src/data/locations.dart';
export 'src/data/cities.dart';
export 'src/data/team_names.dart';
export 'src/data/nfl_structure.dart';
