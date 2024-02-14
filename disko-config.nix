{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # device = "/dev/disk/by-id/some-disk-id";
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
                  "@/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "@/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "@/swap" = {
                      mountpoint = "/.swap";
                      mountOptions = ["noatime" "nodatacow" "nodatasum" "discard=async"];
                      swap = {
                        swap-0.size = "8G";
                        swap-0.path = "swap-0";
                      };
                    };
                };
              };
            };
            # lvm = {};
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
  };
}
