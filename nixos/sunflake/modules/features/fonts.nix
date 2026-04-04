{ self, inputs, ... }:
{
  flake.nixosModules.fonts =
    {
      pkgs,
      lib,
      config,
      ...
    }: # let
    # Create a package from your local fonts
    # myFonts = pkgs.stdenv.mkDerivation {
    #    name = "sunvars-fonts";
    #    src = ./fonts;

    #     installPhase = ''
    #      mkdir -p $out/share/fonts
    # Copy all font files recursively
    #      find $src -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} $out/share/fonts/ \;
    #       '';
    #    };

    #  in
    {

      fonts.packages = with pkgs; [
        # Noto
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji

        # DM
        dm-sans
        dm-mono

        # roboto
        roboto
        roboto-slab
        roboto-mono
        roboto-flex
        roboto-serif

        # Fira
        fira
        fira-code
        fira-code-symbols

        # singles
        # mono
        jetbrains-mono
        source-code-pro
        # sans
        open-sans
        lato
        figtree
        montserrat
        raleway
        quicksand
        ibm-plex
        comfortaa
        #serif
        libre-baskerville
        garamond-libre

        # Nerd fonts
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.roboto-mono
        nerd-fonts.symbols-only

        myFonts

      ];

      environment.systemPackages = with pkgs; [
        fontconfig
        freetype
      ];

      fonts.fontconfig = {
        enable = true;

        defaultFonts = {
          serif = [ "libre-baskerville" ];
          sansSerif = [ "dm-sans" ];
          monospace = [ "dm-mon" ];
          emoji = [ "noto-fonts-emoji" ];

        };

      };

    };

}
