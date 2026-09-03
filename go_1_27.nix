{
  lib,
  stdenv,
  fetchurl,
}:
let
  platform = "${stdenv.hostPlatform.go.GOOS}-${stdenv.hostPlatform.go.GOARCH}";
  version = "1.27.1";
  hashes = {
    # Checksums from https://go.dev/dl/
    # https://go.dev/dl/#:~:text=darwin%2Darm64.tar.gz
    darwin-arm64 = "ee215d57e0ec269c60cc9ceca68e6bda321ba9ee5afe24f4b0988703c2d87d12";
    linux-amd64 = "";
    linux-arm64 = "";
  };
in
stdenv.mkDerivation {
  inherit version;
  pname = "go";

  src = fetchurl {
    url = "https://go.dev/dl/go${version}.${platform}.tar.gz";
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
