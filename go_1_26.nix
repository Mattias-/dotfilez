{
  lib,
  stdenv,
  fetchurl,
}:
let
  platform = "${stdenv.hostPlatform.go.GOOS}-${stdenv.hostPlatform.go.GOARCH}";
  hashes = {
    # Checksums from https://go.dev/dl/
    darwin-arm64 = "353df43a7811ce284c8938b5f3c7df40b7bfb6f56cb165b150bc40b5e2dd541f";
    linux-amd64 = "";
    linux-arm64 = "";
  };
in
stdenv.mkDerivation {
  pname = "go";
  version = "1.26.1";

  src = fetchurl {
    url = "https://go.dev/dl/go1.26.1.${platform}.tar.gz";
    sha256 = hashes.${platform} or (throw "Missing Go hash for platform ${platform}");
  };

  dontStrip = stdenv.hostPlatform.isDarwin;

  # Make available attributes required by buildGoModule as passthru.
  passthru = {
    CGO_ENABLED = if stdenv.hostPlatform.isDarwin then 1 else 0;
    GOOS = stdenv.hostPlatform.go.GOOS;
    GOARCH = stdenv.hostPlatform.go.GOARCH;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/go $out/bin
    cp -r . $out/share/go
    ln -s $out/share/go/bin/go $out/bin/go
    ln -s $out/share/go/bin/gofmt $out/bin/gofmt
    runHook postInstall
  '';

  meta = {
    description = "Go programming language (pre-built binary)";
    homepage = "https://go.dev/";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.darwin ++ lib.platforms.linux;
  };
}
