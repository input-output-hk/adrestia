{ config, lib, pkgs, ... }: {
  services.postgresql = {
    enable = true;
    # initialScript = pkgs.writeText "synapse-init.sql" ''
    #   CREATE ROLE "${config.services.matrix-synapse.database_user}" WITH LOGIN PASSWORD 'synapse';
    #   CREATE DATABASE "${config.services.matrix-synapse.database_name}" WITH OWNER "${config.services.matrix-synapse.database_user}"
    #     TEMPLATE template0
    #     LC_COLLATE = "C"
    #     LC_CTYPE = "C";
    # '';
  };
}
