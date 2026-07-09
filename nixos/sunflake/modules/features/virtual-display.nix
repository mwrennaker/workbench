{ self, inputs, ... }:
{
  flake.nixosModules.sunshineVirtualDisplay =
    { pkgs, ... }:
    let
      connector = "HDMI-A-1"; # confirmed disconnected on card1 (same GPU as DP-2/HDMI-A-2)
      edidName = "samsung-q800t-hdmi2.1";
      edidFile = pkgs.fetchurl {
        url = "https://git.linuxtv.org/v4l-utils.git/plain/utils/edid-decode/data/samsung-q800t-hdmi2.1";
        sha256 = "0r3v1mzpkalgdhnnjfq8vbg4ian3pwziv0klb80zw89w1msfm9nh";
      };
      swaymsg = "${pkgs.sway}/bin/swaymsg";

      # Sway's cursor querying is more limited than Hyprland's; we use `swaymsg -t get_seats`
      # to pull the cursor position out of JSON via jq.
      jq = "${pkgs.jq}/bin/jq";

      prepScript = pkgs.writeShellScript "sunshine-prep" ''
        # Save current cursor position
        ${swaymsg} -t get_seats -r | ${jq} -r '.[0] | "\(.pointer.x // 0) \(.pointer.y // 0)"' > /tmp/sunshine-cursor-pos

        ${swaymsg} output ${connector} enable mode 1920x1080@60Hz position 5760,0
        sleep 2
        ${swaymsg} output DP-2 disable
        ${swaymsg} output HDMI-A-2 disable

        # Move cursor to center of the virtual display via a synthetic click-free warp.
        # Sway doesn't expose a direct "movecursor" IPC command like Hyprland;
        # `swaymsg seat - cursor set X Y` is the closest equivalent (needs recent sway).
        ${swaymsg} seat seat0 cursor set 960 540
      '';

      exitScript = pkgs.writeShellScript "sunshine-exit" ''
        ${swaymsg} output DP-2 enable mode 3840x2160@144.050Hz position 0,0
        ${swaymsg} output HDMI-A-2 enable mode 1920x1080@60Hz position 3840,0
        ${swaymsg} output ${connector} disable

        if [ -f /tmp/sunshine-cursor-pos ]; then
          read -r X Y < /tmp/sunshine-cursor-pos
          ${swaymsg} seat seat0 cursor set "$X" "$Y"
          rm /tmp/sunshine-cursor-pos
        fi
      '';
    in
    {
      hardware.firmware = [
        (pkgs.runCommand "virtual-display-edid" { } ''
          mkdir -p $out/lib/firmware/edid
          cp ${edidFile} $out/lib/firmware/edid/${edidName}
        '')
      ];
      boot.kernelParams = [
        "drm.edid_firmware=${connector}:edid/${edidName}"
        "video=${connector}:e"
      ];
      services.sunshine.settings = {
        global_prep_cmd = builtins.toJSON [
          {
            do = "${prepScript}";
            undo = "${exitScript}";
            elevated = false;
          }
        ];
      };
    };
}
