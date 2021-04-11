{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
      vscode
      ruby_2_7 
      bundler
      git
      sqlite
      nodejs
      yarn
 ];
}
