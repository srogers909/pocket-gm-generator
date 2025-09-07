/// NFL league structure with exact divisions and city assignments
/// This ensures teams are generated with the correct divisional alignment

/// NFL Division structure with city assignments
const Map<String, Map<String, List<String>>> nflStructure = {
  'LFC': {
    'East': ['Buffalo', 'Miami', 'New England', 'New York'],
    'North': ['Baltimore', 'Cincinnati', 'Cleveland', 'Pittsburgh'],
    'South': ['Houston', 'Indianapolis', 'Jacksonville', 'Tennessee'],
    'West': ['Denver', 'Kansas City', 'Las Vegas', 'Los Angeles'],
  },
  'FFC': {
    'East': ['Dallas', 'New York', 'Philadelphia', 'Washington'],
    'North': ['Chicago', 'Detroit', 'Green Bay', 'Minnesota'],
    'South': ['Atlanta', 'Carolina', 'New Orleans', 'Tampa Bay'],
    'West': ['Arizona', 'Los Angeles', 'San Francisco', 'Seattle'],
  },
};

/// Gets all conference names
List<String> get conferenceNames => nflStructure.keys.toList();

/// Gets all division names for a conference
List<String> getDivisionNames(String conference) {
  return nflStructure[conference]?.keys.toList() ?? [];
}

/// Gets all cities for a specific division
List<String> getDivisionCities(String conference, String division) {
  return nflStructure[conference]?[division] ?? [];
}

/// Gets the total number of teams in the NFL structure
int get totalNflTeams {
  int total = 0;
  for (final conference in nflStructure.values) {
    for (final division in conference.values) {
      total += division.length;
    }
  }
  return total;
}

/// Validates that the NFL structure has exactly 32 teams
bool get isValidNflStructure {
  return totalNflTeams == 32 && 
         nflStructure.length == 2 && // 2 conferences
         nflStructure.values.every((conference) => 
           conference.length == 4 && // 4 divisions per conference
           conference.values.every((division) => division.length == 4) // 4 teams per division
         );
}

/// Gets a readable division name (e.g., "AFC East")
String getFullDivisionName(String conference, String division) {
  return '$conference $division';
}

/// Gets conference and division for a specific city
Map<String, String>? getConferenceAndDivision(String city) {
  for (final conference in nflStructure.entries) {
    for (final division in conference.value.entries) {
      if (division.value.contains(city)) {
        return {
          'conference': conference.key,
          'division': division.key,
        };
      }
    }
  }
  return null;
}
