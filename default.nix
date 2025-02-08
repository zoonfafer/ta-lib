{ pkgs ? import <nixpkgs> { }
, lib ? pkgs.lib
, stdenv ? pkgs.stdenv
}:

stdenv.mkDerivation rec {
  pname = "ta-lib";
  version = "unstable";
  src = ./.;

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    autoreconfHook
  ];

  hardeningDisable = [ "format" ];

  outputs = [ "out" "dev" ];

  meta = with lib; {
    homepage = "https://github.com/TA-Lib/ta-lib";
    description = "TA-Lib (Core C Library)";
    license = licenses.bsd3;
    platforms = platforms.all;
    # maintainers = with maintainers; [ zoonfafer ];
  };

}
