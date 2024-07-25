# backend-services

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

umbrella chart for invenio backend services
  * redis
  * rabbit
  * opensearch
  * postgresql

## Requirements

## required k8s components

* cloudnative postgresql operator **[cn-pg github](https://github.com/cloudnative-pg/cloudnative-pg)**
* cloudnative cert-manager **[cert-manager github](https://github.com/cert-manager/cert-manager)**
* any CSI driver

## helm dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | rabbitmq | 14.3.1 |
| https://charts.bitnami.com/bitnami | redis | 19.5.0 |
| https://opensearch-project.github.io/helm-charts/ | opensearch | 2.20.0 |
| oci://hub.cerit.io/steiner/helm-charts | cn-pg | 0.3.1 |
| oci://hub.cerit.io/steiner/helm-charts | common | 0.5.1 |

## Values

* as a best practice use for S3 secret values another values file

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cn-pg.fullNameOverride | string | `"bagr"` |  |
| cn-pg.certs.issuerRef.name | string | `"ca-cluster-issuer"` |  |
| cn-pg.certs.issuerRef.kind | string | `"ClusterIssuer"` |  |
| cn-pg.certs.issuerRef.group | string | `"cert-manager.io"` |  |
| cn-pg.cluster.name | string | `"nma"` |  |
| cn-pg.cluster.instances | int | `3` |  |
| cn-pg.cluster.logLevel | string | `"info"` |  |
| cn-pg.cluster.resources.limits.memory | string | `"2048Mi"` |  |
| cn-pg.cluster.resources.limits.cpu | string | `"2.0"` |  |
| cn-pg.cluster.storage.size | string | `"50Gi"` |  |
| cn-pg.cluster.walStorage.size | string | `"50Gi"` |  |
| cn-pg.cluster.bootstrap.initdb.database | string | `"eosccz_repo_nma_test"` |  |
| cn-pg.cluster.bootstrap.initdb.owner | string | `"eosccz_repo_nma_test"` |  |
| cn-pg.cluster.backup.barmanObjectStore.destinationPath | string | `"s3://test/backup/cn-pg-testing-nma/"` |  |
| cn-pg.cluster.backup.barmanObjectStore.endpointURL | string | `"https://s3.be.du.cesnet.cz"` |  |
| redis.passwordLength | int | `64` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.existingSecret | string | `"blabla-bleble-neco-neco-backend-services-redis"` |  |
| redis.auth.existingSecretPasswordKey | string | `"redisPassword"` |  |
| redis.auth.existing_secret | bool | `true` |  |
| redis.auth.secret_name | string | `"blabla-bleble-neco-neco-backend-services-redis"` |  |
| redis.auth.secret_key | string | `"redisPassword"` |  |
| redis.metrics.enabled | bool | `false` |  |
| opensearch.singleNode | bool | `true` |  |
| opensearch.opensearchJavaOpts | string | `"-Xmx4096M -Xms4096M"` |  |
| opensearch.resources.requests.cpu | string | `"500m"` |  |
| opensearch.resources.requests.memory | string | `"6Gi"` |  |
| opensearch.resources.limits.cpu | string | `"1500m"` |  |
| opensearch.resources.limits.memory | string | `"6Gi"` |  |
| opensearch.extraEnvs[0].name | string | `"DISABLE_INSTALL_DEMO_CONFIG"` |  |
| opensearch.extraEnvs[0].value | string | `"true"` |  |
| opensearch.extraEnvs[1].name | string | `"DISABLE_SECURITY_PLUGIN"` |  |
| opensearch.extraEnvs[1].value | string | `"true"` |  |
| opensearch.plugins.enabled | bool | `true` |  |
| opensearch.plugins.installList[0] | string | `"analysis-icu"` |  |
| rabbitmq.commonAnnotations.version/values | string | `"1.0.0"` |  |
| rabbitmq.passwordLength | int | `64` |  |
| rabbitmq.erlangCookieLength | int | `128` |  |
| rabbitmq.auth.username | string | `"user"` |  |
| rabbitmq.auth.existingPasswordSecret | string | `"blabla-bleble-neco-neco-backend-services-rabbitmq"` |  |
| rabbitmq.auth.existingSecretPasswordKey | string | `"rabbitmqPassword"` |  |
| rabbitmq.auth.existingErlangSecret | string | `"blabla-bleble-neco-neco-backend-services-rabbitmq"` |  |
| rabbitmq.auth.existingSecretErlangKey | string | `"rabbitmqErlangCookie"` |  |

