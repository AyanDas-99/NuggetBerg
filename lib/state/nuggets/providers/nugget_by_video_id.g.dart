// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nugget_by_video_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nuggetByVideoHash() => r'771a5e3cc246490b9e0d49917276e5a5a9611a97';

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

/// See also [nuggetByVideo].
@ProviderFor(nuggetByVideo)
const nuggetByVideoProvider = NuggetByVideoFamily();

/// See also [nuggetByVideo].
class NuggetByVideoFamily extends Family<AsyncValue<Nugget?>> {
  /// See also [nuggetByVideo].
  const NuggetByVideoFamily();

  /// See also [nuggetByVideo].
  NuggetByVideoProvider call(
    Video video,
  ) {
    return NuggetByVideoProvider(
      video,
    );
  }

  @override
  NuggetByVideoProvider getProviderOverride(
    covariant NuggetByVideoProvider provider,
  ) {
    return call(
      provider.video,
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
  String? get name => r'nuggetByVideoProvider';
}

/// See also [nuggetByVideo].
class NuggetByVideoProvider extends AutoDisposeFutureProvider<Nugget?> {
  /// See also [nuggetByVideo].
  NuggetByVideoProvider(
    Video video,
  ) : this._internal(
          (ref) => nuggetByVideo(
            ref as NuggetByVideoRef,
            video,
          ),
          from: nuggetByVideoProvider,
          name: r'nuggetByVideoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nuggetByVideoHash,
          dependencies: NuggetByVideoFamily._dependencies,
          allTransitiveDependencies:
              NuggetByVideoFamily._allTransitiveDependencies,
          video: video,
        );

  NuggetByVideoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.video,
  }) : super.internal();

  final Video video;

  @override
  Override overrideWith(
    FutureOr<Nugget?> Function(NuggetByVideoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NuggetByVideoProvider._internal(
        (ref) => create(ref as NuggetByVideoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        video: video,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Nugget?> createElement() {
    return _NuggetByVideoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NuggetByVideoProvider && other.video == video;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, video.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NuggetByVideoRef on AutoDisposeFutureProviderRef<Nugget?> {
  /// The parameter `video` of this provider.
  Video get video;
}

class _NuggetByVideoProviderElement
    extends AutoDisposeFutureProviderElement<Nugget?> with NuggetByVideoRef {
  _NuggetByVideoProviderElement(super.provider);

  @override
  Video get video => (origin as NuggetByVideoProvider).video;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
