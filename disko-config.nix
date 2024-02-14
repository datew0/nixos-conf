{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          {
            name = "ESP";
            size = "1G";
            type = "EF00";
            priority = 0;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            size = "100G";
            content = {
              type = "btrfs";
              mountpoint = "/";
              mountOptions = ["noatime"];
              subvolumes = {
                "@home" = {
                  mountOptions = [ "compress=zstd" ];
                  mountpoint = "/home";
                };
                "@nix" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                  mountpoint = "/nix";
                };
              };
            };
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