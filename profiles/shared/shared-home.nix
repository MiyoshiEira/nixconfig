{ config, pkgs, lib, userSettings, ... }:


{
imports = [ 
              ../../modules/home/required
              ../../modules/home/main
            ];
}
