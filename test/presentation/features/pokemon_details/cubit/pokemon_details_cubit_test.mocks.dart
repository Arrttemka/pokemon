import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pokemon/domain/entities/pokemon_entity.dart' as _i7;
import 'package:pokemon/domain/failures/failures.dart' as _i6;
import 'package:pokemon/domain/repositories/pokemon_repository.dart' as _i2;
import 'package:pokemon/domain/usecases/get_pokemon_details_use_case.dart' as _i4;

class _FakePokemonRepository_0 extends _i1.SmartFake
    implements _i2.PokemonRepository {
  _FakePokemonRepository_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class MockGetPokemonDetailsUseCase extends _i1.Mock
    implements _i4.GetPokemonDetailsUseCase {
  MockGetPokemonDetailsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PokemonRepository get repository => (super.noSuchMethod(
    Invocation.getter(#repository),
    returnValue: _FakePokemonRepository_0(
      this,
      Invocation.getter(#repository),
    ),
  ) as _i2.PokemonRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.PokemonEntity>> call(int? id) =>
      (super.noSuchMethod(
        Invocation.method(#call, [id]),
        returnValue:
        _i5.Future<_i3.Either<_i6.Failure, _i7.PokemonEntity>>.value(
          _FakeEither_1<_i6.Failure, _i7.PokemonEntity>(
            this,
            Invocation.method(#call, [id]),
          ),
        ),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.PokemonEntity>>);
}