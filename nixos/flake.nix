{
  description = "NixOS configuration with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    hyprmod.url = "github:BlueManCZ/hyprmod";
    hyprmod.inputs.nixpkgs.follows = "nixpkgs";
    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprmod, firefox }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit; };
      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [ hyprmod.overlays.default ];
        }
      ];
    };
  };
}
