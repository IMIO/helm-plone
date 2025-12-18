# Plone Helm Chart

This Helm chart deploys Plone CMS on Kubernetes with all required dependencies.

## Components

This chart includes the following components:

- **Plone Instance**: Main Plone CMS application
- **PostgreSQL**: Database backend using RelStorage
- **Solr**: Search engine integration (version 9.6.1)
- **Memcached**: Caching layer

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure (for persistent volumes)

## Installation

To install the chart with the release name `my-plone`:

```bash
helm install my-plone .
```

To install with custom values:

```bash
helm install my-plone . -f custom-values.yaml
```

## Configuration

The following table lists the configurable parameters and their default values.

### Plone Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of Plone replicas | `1` |
| `image.repository` | Plone image repository | `plone` |
| `image.tag` | Plone image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service port | `8080` |

### PostgreSQL Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `postgresql.enabled` | Enable PostgreSQL | `true` |
| `postgresql.auth.database` | Database name | `zope` |
| `postgresql.auth.username` | Database user | `zope` |
| `postgresql.auth.password` | Database password | `zope` |
| `postgresql.primary.persistence.enabled` | Enable persistence | `true` |
| `postgresql.primary.persistence.size` | PVC size | `8Gi` |

### Solr Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `solr.enabled` | Enable Solr | `true` |
| `solr.image.repository` | Solr image repository | `solr` |
| `solr.image.tag` | Solr image tag | `9.6.1-slim` |
| `solr.port` | Solr port | `8983` |
| `solr.persistence.enabled` | Enable persistence | `true` |
| `solr.persistence.size` | PVC size | `8Gi` |

### Memcached Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `memcached.enabled` | Enable Memcached | `true` |
| `memcached.image.repository` | Memcached image repository | `memcached` |
| `memcached.image.tag` | Memcached image tag | `1.5.20` |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.hosts[0].host` | Hostname | `portal.localhost` |

## Environment Variables

All Plone environment variables can be configured under `plone.env` in values.yaml. Default configuration includes:

- RelStorage configuration for PostgreSQL
- Solr integration settings
- Memcached settings
- Plone extensions and language settings
- Authentication settings (Authentic integration)

## Uninstallation

To uninstall/delete the `my-plone` deployment:

```bash
helm uninstall my-plone
```

This command removes all the Kubernetes components associated with the chart and deletes the release.

## Persistence

By default, the chart creates PersistentVolumeClaims for both PostgreSQL and Solr. You can disable persistence by setting:

```yaml
postgresql:
  primary:
    persistence:
      enabled: false

solr:
  persistence:
    enabled: false
```

## Upgrading

To upgrade the chart:

```bash
helm upgrade my-plone .
```

## Notes

- The Plone image repository should be updated to point to your actual Plone image
- Database credentials should be changed in production environments
- For production use, consider enabling ingress and configuring proper hostnames
- The chart uses service name templating for PostgreSQL and Solr to ensure proper DNS resolution within the cluster
