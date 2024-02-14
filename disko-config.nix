{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/<...>";
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
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "@home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  "@swap" = {
                      mountpoint = "/.swap";
                      mountOptions = ["noatime" "nodatacow" "nodatasum" "discard=async"];
                      swap = {
                        swap.size = "8G";
                        swap.path = "swap";
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
