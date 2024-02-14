{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              priority = 0;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            sys = {
              size = "100G";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" ];
                  };
                  # "@swap" = {
                  #     mountpoint = "/.swap";
                  #     mountOptions = ["noatime" "nodatacow" "nodatasum" "discard=async"];
                  #     swap = {
                  #       swap.size = "8G";
                  #       swap.path = "swap";
                  #     };
                  #   };
                };
              };
            };
            # lvm = {};
          };
        };
      };
    };
  };
}
