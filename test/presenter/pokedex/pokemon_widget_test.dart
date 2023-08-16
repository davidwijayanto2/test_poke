import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_poke/presenter/pokedex/bloc/get_pokedex_bloc.dart';
import 'package:test_poke/presenter/pokedex/view/pokedex.dart';

import 'pokemon_bloc_test.dart';

class MockGetPokedexBloc extends MockCubit<GetPokedexState>
    implements GetPokedexBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GetPokedexBloc blocProvider;

  setUp(() {
    blocProvider = MockGetPokedexBloc();
    //     GetPokedexSuccessState(pokemon: mockPokemon));
  });

  testWidgets(
    'Test Widget pokedex',
    (WidgetTester tester) async {
      when(blocProvider.state)
          .thenReturn(GetPokedexSuccessState(pokemon: mockPokemon));
      await tester.pumpWidget(
        BlocProvider.value(
          value: blocProvider,
          child: MaterialApp(home: Builder(builder: (context) {
            return const PokedexView();
          })),
        ),
      );
      await tester.pumpAndSettle();
      expect(blocProvider.state, isA<GetPokedexSuccessState>());
      expect(find.byType(PokemonCard), findsWidgets);
      // provider.filteredWorkOrderList = WorkOrder().woFromJson(response);
      // expect(find.byKey(const Key('empty')), findsOneWidget);
      // await tester.pumpAndSettle(const Duration(seconds: 5));
      // expect(provider.filteredWorkOrderList[0].woId, 10592);
      // provider.isFetching = false;
      // expect(
      //     find.byKey(Key('selected${provider.filteredWorkOrderList[0].woId}')),
      //     findsOneWidget);
      // var btn =
      //     find.byKey(Key('selected${provider.filteredWorkOrderList[0].woId}'));
      // await tester.pumpAndSettle(const Duration(seconds: 5));
      // await tester.tap(btn);
      // expect(woId, '10592');
      // await tester.pumpAndSettle(const Duration(seconds: 5));
      // await tester.enterText(find.byType(CupertinoTextField), 'asdknr');
      // await tester.pumpAndSettle(const Duration(seconds: 3));
      // expect(provider.filteredWorkOrderList.length, 0);
      // expect(provider.selectWOTextController.text, 'asdknr');
      // await tester.tap(find.byType(Icon));
      // await tester.pumpAndSettle(const Duration(seconds: 3));
    },
  );
}
