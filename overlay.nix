final: prev:

let ta-lib = prev.callPackage ./. { }; in

{
  inherit ta-lib;
}
