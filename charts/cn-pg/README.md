# cn-pg

![Version: 0.3.1](https://img.shields.io/badge/Version-0.3.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 16](https://img.shields.io/badge/AppVersion-16-informational?style=flat-square)

## Requirements

## required k8s components

* cloudnative postgresql operator **[cn-pg github](https://github.com/cloudnative-pg/cloudnative-pg)**
* cloudnative cert-manager **[cert-manager github](https://github.com/cert-manager/cert-manager)**
* any CSI driver

## helm dependencies

| Repository | Name | Version |
|------------|------|---------|
| oci://hub.cerit.io/steiner/helm-charts | common | 0.7.3 |

## Values

* as a best practice use for S3 secret values another values file

### S3 config

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| s3 | object | none  | use for secret values extra file |
| s3.useExternalSecret | bool | false | If set to true, cluster use external s3 config |
| s3.externalSecretName | string | `nil` | If a `useExternalSecret` is set to `true` you need to set `secretName` |
| s3.accessKeyId | string | `accessKeyId` | please fill right accessKeyId |
| s3.secretAccessKey | string | `secretAccessKey` | please fill right secretAccessKey  |
| s3.region | string | region | please fill right region, content depends on S3 provider |
| s3.s3EndpointUrl | string | `"https://s3.endpoint.my.domain/"` | please fill right id, key, region and endpoint |
| s3.secretNameSuffix | string | s3-keys | suffix for cretaed secret |

### Certs issuer settings depends on `cert-manager.io`

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certs.issuerRef.name | string | you have to set your own issuer | name of the issuer or cluster issuer |
| certs.issuerRef.kind | string | `Issuer` or `ClusterIssuer` | You have to choose from two options |
| certs.issuerRef.group | string | `cert-manager.io` | set to cert-manager.io |

### Certs settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certs.server.secretSuffix | string | `server-cert` | secret's name suffix. secret full name would be releasename-cn-pg-secretSuffix |
| certs.server.duration | string | `26280h` | Cert's duration |
| certs.server.renewBefore | string | `720h` | Cert's renew,  usually 30d |
| certs.server.usages | list | `server auth` | purpose of the cert |
| certs.client.secretSuffix | string | `client-cert` | secret's name suffix. secret full name would be releasename-cn-pg-secretSuffix |
| certs.client.duration | string | `26280h` | Cert's duration |
| certs.client.renewBefore | string | `720h` | Cert's renew,  usually 30d |
| certs.client.usages | list | `client auth` | purpose of the cert |
| certs.client.commonName | string | `streaming_replica` | client CN, default is required by cn-pg operator |

### Cluster

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.instances | int | `3` |  |
| cluster.minSyncReplicas | int | `1` |  |
| cluster.maxSyncReplicas | int | `2` |  |

### Cluster storage 

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.storage.size | string | 50GB | provisioned disk size for PGDATA |
| cluster.walStorage.size | string | 50GB | provisioned disk size for WALS  |

### Cluster storage

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.storage.storageClass | string | `storageclass name` | if present set storage class |
| cluster.walStorage.storageClass | string | `storageclass name` | if present set storage class |

### Cluster resources

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.resources.requests.memory | string | `512Mi` | requested RAM |
| cluster.resources.requests.cpu | string | `"50m"` | requested CPU |
| cluster.resources.limits.memory | string | `"1024Mi"` | limit RAM |
| cluster.resources.limits.cpu | string | `"1.0"` | limit CPU |

### Cluster bootstrap

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.bootstrap.initdb.dataChecksums | bool | true | enable segment checksums |
| cluster.bootstrap.initdb.encoding | string | UTF8 | encoding for entire cluster |
| cluster.bootstrap.initdb.database | string | `"example_db"` | you have to create db, this is right place @default - none, you have your own db |
| cluster.bootstrap.initdb.owner | string | `"example_user"` | db owner.  @default - none, you have to set any name you need. |
| cluster.bootstrap.initdb.localeCollate | string | `C` | collation,  |
| cluster.bootstrap.initdb.localeCType | string | `C` | CType |
| cluster.bootstrap.initdb.walSegmentSize | int | 16MB | size of wal files |

### Cluster backup

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.backup.retentionPolicy | string | none | retention policy for backup and wals |
| cluster.backup.barmanObjectStore.destinationPath | string | none | bucket name and optionally subpath |
| cluster.backup.barmanObjectStore.endpointURL | string | none | S3 endpoint https address  |
| cluster.backup.barmanObjectStore.wal.compression | string | none, usually set to bzip2 | set archivelog compression |
| cluster.backup.barmanObjectStore.wal.maxParallel | int | 1 | set archivelog parallelism |
| cluster.backup.barmanObjectStore.data.compression | string | usually set to bzip2 | basebackup  compression |
| cluster.backup.barmanObjectStore.data.immediateCheckpoint | bool | false | if immediate checkpoit is set  |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.scheduledBackup.nameSuffix | string | scheduled-backup | name suffix of your backup job @section - Cluster scheduled backup |
| cluster.scheduledBackup.schedule | string | "25 24 23 * * *" | cn-pg ScheduledBackup starts with seconds! @section - Cluster scheduled backup |
