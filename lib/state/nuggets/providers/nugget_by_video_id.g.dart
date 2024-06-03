// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nugget_by_video_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nuggetByVideoIdHash() => r'17aacc8796ab1412ad8ae7b882fc0312e05dd7b6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [nuggetByVideoId].
@ProviderFor(nuggetByVideoId)
const nuggetByVideoIdProvider = NuggetByVideoIdFamily();

/// See also [nuggetByVideoId].
class NuggetByVideoIdFamily extends Family<AsyncValue<Nugget>> {
  /// See also [nuggetByVideoId].
  const NuggetByVideoIdFamily();

  /// See also [nuggetByVideoId].
  NuggetByVideoIdProvider call(
    String videoId,
  ) {
    return NuggetByVideoIdProvider(
      videoId,
    );
  }

  @override
  NuggetByVideoIdProvider getProviderOverride(
    covariant NuggetByVideoIdProvider provider,
  ) {
    return call(
      provider.videoId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nuggetByVideoIdProvider';
}

/// See also [nuggetByVideoId].
class NuggetByVideoIdProvider extends AutoDisposeFutureProvider<Nugget> {
  /// See also [nuggetByVideoId].
  NuggetByVideoIdProvider(
    String videoId,
  ) : this._internal(
          (ref) => nuggetByVideoId(
            ref as NuggetByVideoIdRef,
            videoId,
          ),
          from: nuggetByVideoIdProvider,
          name: r'nuggetByVideoIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nuggetByVideoIdHash,
          dependencies: NuggetByVideoIdFamily._dependencies,
          allTransitiveDependencies:
              NuggetByVideoIdFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  NuggetByVideoIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.videoId,
  }) : super.internal();

  final String videoId;

  @override
  Override overrideWith(
    FutureOr<Nugget> Function(NuggetByVideoIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NuggetByVideoIdProvider._internal(
        (ref) => create(ref as NuggetByVideoIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        videoId: videoId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Nugget> createElement() {
    return _NuggetByVideoIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NuggetByVideoIdProvider && other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NuggetByVideoIdRef on AutoDisposeFutureProviderRef<Nugget> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _NuggetByVideoIdProviderElement
    extends AutoDisposeFutureProviderElement<Nugget> with NuggetByVideoIdRef {
  _NuggetByVideoIdProviderElement(super.provider);

  @override
  String get videoId => (origin as NuggetByVideoIdProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
