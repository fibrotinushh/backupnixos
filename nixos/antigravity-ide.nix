{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) lib stdenv fetchurl autoPatchelfHook makeWrapper
    alsa-lib at-spi2-atk at-spi2-core cups dbus expat glib
    libGL libdrm libsecret libxkbcommon mesa nspr nss
    pango xorg zlib fontconfig freetype makeDesktopItem
    copyDesktopItems gtk3 libxkbfile;
in
stdenv.mkDerivation rec {
  pname = "antigravity-ide";
  version = "2.5.5";
  buildId = "4923483625488384";

  src = fetchurl {
    url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/${version}-${buildId}/linux-x64/Antigravity%20IDE.tar.gz";
    sha256 = "sha256-DFIzspfSs667Ya9J+JRAEsKVPTYaXrsWl4SQY2kX+DE=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper copyDesktopItems ];

  buildInputs = [
    alsa-lib at-spi2-atk at-spi2-core cups dbus expat glib
    libGL libdrm libsecret libxkbcommon mesa nspr nss pango
    stdenv.cc.cc.lib zlib fontconfig freetype gtk3 libxkbfile
    xorg.libX11 xorg.libXcomposite xorg.libXdamage xorg.libXext
    xorg.libXfixes xorg.libXrandr xorg.libXScrnSaver xorg.libxcb
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libwebkit2gtk-4.1.so.0"
    "libsoup-3.0.so.0"
    "libgdk-3.so.0"
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "antigravity-ide";
      exec = "antigravity-ide %U";
      icon = "antigravity-ide";
      type = "Application";
      comment = "Google Antigravity IDE - AI-powered agentic editor";
      desktopName = "Antigravity IDE";
      categories = [ "Development" "IDE" ];
      startupWMClass = "antigravity-ide";
    })
  ];

  postUnpack = ''
    mv "$sourceRoot" antigravity-ide-src
    sourceRoot=antigravity-ide-src
  '';

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/antigravity-ide
    cp -r ./* $out/share/antigravity-ide/

    chmod +x $out/share/antigravity-ide/antigravity-ide
    chmod +x $out/share/antigravity-ide/chrome-sandbox
    chmod +x $out/share/antigravity-ide/chrome_crashpad_handler

    mkdir -p $out/bin
    makeWrapper $out/share/antigravity-ide/antigravity-ide $out/bin/antigravity-ide \
      --add-flags "--ozone-platform=x11" \
      --set-default ELECTRON_OZONE_PLATFORM_HINT x11

    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp $out/share/antigravity-ide/resources/app/resources/linux/code.png \
       $out/share/icons/hicolor/512x512/apps/antigravity-ide.png

    runHook postInstall
  '';

  meta = with lib; {
    description = "Google Antigravity IDE - AI-powered agentic editor";
    homepage = "https://antigravity.google/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "antigravity-ide";
  };
}
