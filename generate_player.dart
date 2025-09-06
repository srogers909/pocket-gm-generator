import 'lib/pocket_gm_generator.dart';

void main(List<String> args) {
  final generator = PlayerGenerator();
  
  // Default to generating 1 player unless specified
  int count = 1;
  if (args.isNotEmpty) {
    count = int.tryParse(args[0]) ?? 1;
  }
  
  print('🏈 Generating $count player${count > 1 ? 's' : ''} with new bell curve distribution...\n');
  
  for (int i = 0; i < count; i++) {
    if (count > 1) print('--- Player ${i + 1} ---');
    
    final player = generator.generatePlayer();
    print(player.toString());
    
    if (i < count - 1) print('');
  }
  
  print('\n✅ Generation complete!');
}
