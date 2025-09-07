// ignore: avoid_relative_lib_imports
import '../../lib/pocket_gm_generator.dart';

void main() {
  print('🏈 Pro Football Generator Demo 🏈\n');
  print('=' * 50);
  
  // Create player generator instance
  final playerGenerator = PlayerGenerator();
  
  // Generate and display 3 rookie players (ages 21-23, 2025 draft class)
  print('\n🎓 ROOKIE PLAYERS (2025 Draft Class) 🎓');
  for (int i = 1; i <= 3; i++) {
    print('\n--- Generated Rookie #$i ---');
    final player = playerGenerator.generatePlayer();
    print(player.toString());
    print('-' * 30);
  }
  
  // Generate and display 3 veteran players with various ages
  print('\n\n🏆 VETERAN PLAYERS (Ages 19-40) 🏆');
  
  // Generate a specific age veteran (25 years old)
  print('\n--- Generated Veteran #1 (Age 25) ---');
  final veteran1 = playerGenerator.generateVeteranPlayer(age: 25);
  print(veteran1.toString());
  print('-' * 30);
  
  // Generate a young veteran (19 years old)
  print('\n--- Generated Veteran #2 (Age 19) ---');
  final veteran2 = playerGenerator.generateVeteranPlayer(age: 19);
  print(veteran2.toString());
  print('-' * 30);
  
  // Generate a random age veteran (19-40)
  print('\n--- Generated Veteran #3 (Random Age) ---');
  final veteran3 = playerGenerator.generateVeteranPlayer();
  print(veteran3.toString());
  print('-' * 30);
  
  print('\nDemo complete! Run this command again to generate new players.');
}
