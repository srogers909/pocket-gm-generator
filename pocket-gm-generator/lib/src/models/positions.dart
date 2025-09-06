/// Position-specific attribute definitions for football players
/// Each position has three key attributes that define their effectiveness

class PositionAttributes {
  final String attribute1;
  final String attribute2;
  final String attribute3;

  const PositionAttributes({
    required this.attribute1,
    required this.attribute2,
    required this.attribute3,
  });
}

/// Map of football positions to their specific attributes
const Map<String, PositionAttributes> positionAttributeMap = {
  // Quarterback
  'QB': PositionAttributes(
    attribute1: 'Pass Strength',
    attribute2: 'Accuracy',
    attribute3: 'Evasion',
  ),
  
  // Running Back
  'RB': PositionAttributes(
    attribute1: 'Rush Power',
    attribute2: 'Rush Speed',
    attribute3: 'Evasion',
  ),
  
  // Fullback
  'FB': PositionAttributes(
    attribute1: 'Blocking',
    attribute2: 'Rush Power',
    attribute3: 'Catching',
  ),
  
  // Wide Receiver
  'WR': PositionAttributes(
    attribute1: 'Speed',
    attribute2: 'Catching',
    attribute3: 'Route Running',
  ),
  
  // Tight End
  'TE': PositionAttributes(
    attribute1: 'Catching',
    attribute2: 'Blocking',
    attribute3: 'Speed',
  ),
  
  // Offensive Line (Center, Guard, Tackle)
  'OL': PositionAttributes(
    attribute1: 'Pass Blocking',
    attribute2: 'Run Blocking',
    attribute3: 'Strength',
  ),
  'C': PositionAttributes(
    attribute1: 'Pass Blocking',
    attribute2: 'Run Blocking',
    attribute3: 'Strength',
  ),
  'OG': PositionAttributes(
    attribute1: 'Pass Blocking',
    attribute2: 'Run Blocking',
    attribute3: 'Strength',
  ),
  'G': PositionAttributes(
    attribute1: 'Pass Blocking',
    attribute2: 'Run Blocking',
    attribute3: 'Strength',
  ),
  'OT': PositionAttributes(
    attribute1: 'Pass Blocking',
    attribute2: 'Run Blocking',
    attribute3: 'Strength',
  ),
  'T': PositionAttributes(
    attribute1: 'Pass Blocking',
    attribute2: 'Run Blocking',
    attribute3: 'Strength',
  ),
  
  // Defensive Line
  'DL': PositionAttributes(
    attribute1: 'Pass Rush',
    attribute2: 'Run Defense',
    attribute3: 'Strength',
  ),
  'DE': PositionAttributes(
    attribute1: 'Pass Rush',
    attribute2: 'Run Defense',
    attribute3: 'Strength',
  ),
  'DT': PositionAttributes(
    attribute1: 'Pass Rush',
    attribute2: 'Run Defense',
    attribute3: 'Strength',
  ),
  'NT': PositionAttributes(
    attribute1: 'Pass Rush',
    attribute2: 'Run Defense',
    attribute3: 'Strength',
  ),
  
  // Linebacker
  'LB': PositionAttributes(
    attribute1: 'Tackling',
    attribute2: 'Coverage',
    attribute3: 'Speed',
  ),
  'ILB': PositionAttributes(
    attribute1: 'Tackling',
    attribute2: 'Coverage',
    attribute3: 'Speed',
  ),
  'MLB': PositionAttributes(
    attribute1: 'Tackling',
    attribute2: 'Coverage',
    attribute3: 'Speed',
  ),
  'OLB': PositionAttributes(
    attribute1: 'Tackling',
    attribute2: 'Coverage',
    attribute3: 'Speed',
  ),
  
  // Cornerback
  'CB': PositionAttributes(
    attribute1: 'Coverage',
    attribute2: 'Speed',
    attribute3: 'Man Defense',
  ),
  
  // Safety
  'S': PositionAttributes(
    attribute1: 'Coverage',
    attribute2: 'Tackling',
    attribute3: 'Speed',
  ),
  'FS': PositionAttributes(
    attribute1: 'Coverage',
    attribute2: 'Tackling',
    attribute3: 'Speed',
  ),
  'SS': PositionAttributes(
    attribute1: 'Coverage',
    attribute2: 'Tackling',
    attribute3: 'Speed',
  ),
  
  // Kicker
  'K': PositionAttributes(
    attribute1: 'Kick Power',
    attribute2: 'Kick Accuracy',
    attribute3: 'Pressure Resistance',
  ),
  
  // Punter
  'P': PositionAttributes(
    attribute1: 'Punt Power',
    attribute2: 'Punt Accuracy',
    attribute3: 'Pressure Resistance',
  ),
  
  // Long Snapper
  'LS': PositionAttributes(
    attribute1: 'Snap Accuracy',
    attribute2: 'Snap Speed',
    attribute3: 'Blocking',
  ),
};

/// Get position attributes for a given position
/// Returns null if position is not found
PositionAttributes? getPositionAttributes(String position) {
  return positionAttributeMap[position.toUpperCase()];
}

/// Get all available positions
List<String> getAllPositions() {
  return positionAttributeMap.keys.toList();
}

/// Check if a position has Football IQ boost
/// QBs and Safeties get a slight boost to Football IQ
bool hasFootballIqBoost(String position) {
  final pos = position.toUpperCase();
  return pos == 'QB' || pos == 'S' || pos == 'FS' || pos == 'SS';
}
