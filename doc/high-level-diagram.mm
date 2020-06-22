erDiagram
  CARDANO-NODE ||--o{ CARDANO-WALLET : sends-blocks-and-receives-txs
  CARDANO-NODE ||--o{ CARDANO-DB-SYNC : sends-blocks
  CARDANO-NODE ||--o{ CARDANO-SUBMIT-API : receives-txs

  CARDANO-DB-SYNC ||--|| POSTGRESQL : dumps-into

  POSTGRESQL ||--|| CARDANO-GRAPHQL : is-queried
  POSTGRESQL ||--|| CARDANO-EXPLORER-API : is-queried