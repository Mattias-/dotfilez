{
  lib,
  stdenv,
  fetchurl,
}:
let
  platform = "${stdenv.hostPlatform.go.GOOS}-${stdenv.hostPlatform.go.GOARCH}";
  version = "1.26.5";
  hashes = {
    # Checksums from https://go.dev/dl/
    # https://go.dev/dl/#:~:text=darwin%2Darm64.tar.gz
    darwin-arm64 = "efb87ff28af9a188d0536ef5d42e63dd52ba8263cd7344a993cc48dd11dedb6a";
    linux-amd64 = "";
    linux-arm64 = "";
  };
in
stdenv.mkDerivation {
  pname = "go";
  version = version;

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
