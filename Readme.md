Here is the updated `README.md` content with improvements in the structure, references, and additional icons to enhance readability:

# :cloud: Cloud IoT Helm Chart

## :bookmark_tabs: Overview

This Helm chart deploys a set of microservices for a Cloud IoT platform. It includes services like `goApi`, `loki`, and `grafana`, along with their corresponding configuration, deployment, and service resources.

This Helm chart is an extension of the Cloud IoT microservices deployment found in the [cloud-iot-microservices-deployment](https://github.com/manujose94/cloud-iot-microservices-deployment) repository. It builds on the Kubernetes manifests provided in the [kubernetes](https://github.com/manujose94/cloud-iot-microservices-deployment/tree/main/kubernetes) directory of that project, offering a more streamlined, configurable, and reusable solution for deploying the platform's services.


## :scroll: Table of Contents

- [Overview](#bookmark_tabs-overview)
- [Prerequisites](#clipboard-prerequisites)
- [Installation](#rocket-installation)
- [Configuration](#gear-configuration)
  - [Global Settings](#globe_with_meridians-global-settings)
  - [Deployments](#package-deployments)
  - [Services](#gear-services)
  - [Ingress](#world_map-ingress)
  - [Databases](#floppy_disk-databases)
  - [Service Account](#key-service-account)
  - [ConfigMaps](#notebook-configmaps)
- [Running Tests](#test_tube-running-tests)
  - [Viewing Test Results](#mag-right-viewing-test-results)
- [Uninstallation](#wastebasket-uninstallation)
- [Values](#page_facing_up-full-values-table)
- [Secrets](#lock-secrets)
  - [Injecting Secrets Securely](#closed_lock_with_key-injecting-secrets-securely)
  - [Example Deployment Command with Secure Secrets](#closed_lock_with_key-example-deployment-command-with-secure-secrets)
- [Testing Your Chart](#microscope-testing-your-chart)
  - [Linting the Chart](#page_with_curl-linting-the-chart)
  - [Template Rendering](#scroll-template-rendering)
  - [Dry Run](#hourglass_flowing_sand-dry-run)
  - [Validate Kubernetes Manifests](#clipboard-validate-kubernetes-manifests)
  - [Verify Dependencies](#link-verify-dependencies)
  - [Check YAML Syntax](#white_check_mark-check-yaml-syntax)
  - [Unit Testing](#heavy_check_mark-unit-testing)
- [References](#books-references)

## :clipboard: Prerequisites

- Kubernetes cluster (v1.14 or later)
- Helm v3.0 or later
- `kubectl` CLI configured to communicate with your cluster

## :rocket: Installation

You can install the Helm chart with the following command:

```bash
helm install cloud-iot ./cloud-iot-chart
```

Or, to upgrade an existing release:

```bash
helm upgrade --install cloud-iot ./cloud-iot-chart
```

You can pass in custom values using the `--set` flag or by specifying additional values files with `-f`.

For example:

```bash
helm upgrade --install cloud-iot ./cloud-iot-chart \
  --set secrets.postgres.user=$POSTGRES_USER \
  --set secrets.postgres.password=$POSTGRES_PASSWORD \
  --set secrets.postgres.database=$POSTGRES_DB
```

## :gear: Configuration

### :globe_with_meridians: Global Settings

| Key                      | Description                                 | Default       |
| ------------------------ | ------------------------------------------- | ------------- |
| `global.imagePullPolicy`  | Image pull policy for all containers        | `IfNotPresent`|
| `global.labels.project`   | Project label applied to all resources      | `cloud-iot`   |
| `global.labels.version`   | Version label applied to all resources      | `1.0.0`       |

### :package: Deployments

This section allows you to configure the deployments of various services within the platform.

| Key                                 | Description                                              | Default       |
| ----------------------------------- | -------------------------------------------------------- | ------------- |
| `deployments.defaultReplicas`       | Default number of replicas for all deployments           | `1`           |
| `deployments.imagePullPolicy`       | Image pull policy for all deployments                    | `IfNotPresent`|
| `deployments.goApi.enabled`         | Enable the `goApi` service                               | `true`        |
| `deployments.goApi.replicas`        | Number of replicas for `goApi`                           | `1`           |
| `deployments.goApi.resources`       | Resource requests and limits for `goApi`                 | `{}`          |
| `deployments.goSimulator.enabled`   | Enable the `goSimulator` service                         | `true`        |
| `deployments.goSimulator.replicas`  | Number of replicas for `goSimulator`                     | `1`           |
| `deployments.goSimulator.resources` | Resource requests and limits for `goSimulator`           | `{}`          |
| `deployments.iotK8sOperator.enabled`| Enable the `iotK8sOperator` service                      | `false`       |
| `deployments.iotK8sOperator.resources` | Resource requests and limits for `iotK8sOperator`      | `{}`          |

### :gear: Services

This section allows you to configure Kubernetes services for the deployed applications.

| Key                                 | Description                                              | Default       |
| ----------------------------------- | -------------------------------------------------------- | ------------- |
| `services.goApi.enabled`            | Enable the `goApi` service                               | `true`        |
| `services.goApi.name`               | Name of the `goApi` service                              | `go-api-service` |
| `services.goApi.type`               | Type of the `goApi` service (e.g., ClusterIP, NodePort)  | `ClusterIP`   |
| `services.goApi.port`               | Port for the `goApi` service                             | `80`          |
| `services.loki.enabled`             | Enable the `loki` service                                | `true`        |
| `services.loki.name`                | Name of the `loki` service                               | `loki-service`|
| `services.loki.type`                | Type of the `loki` service                               | `ClusterIP`   |
| `services.loki.port`                | Port for the `loki` service                              | `3100`        |
| `services.loki.targetPort`          | Target port for the `loki` service                       | `3100`        |
| `services.grafana.enabled`          | Enable the `grafana` service                             | `false`       |
| `services.grafana.name`             | Name of the `grafana` service                            | `grafana-service`|
| `services.grafana.type`             | Type of the `grafana` service                            | `ClusterIP`   |
| `services.grafana.port`             | Port for the `grafana` service                           | `3000`        |

### :world_map: Ingress

This section allows you to configure ingress resources for the deployed services.

| Key                                | Description                                                | Default               |
| ---------------------------------- | ---------------------------------------------------------- | --------------------- |
| `ingress.enabled`                  | Enable Ingress                                             | `true`                |
| `ingress.className`                | Ingress class name                                         | `nginx`               |
| `ingress.annotations`              | Annotations for the ingress                                | `{}`                  |
| `ingress.hosts`                    | List of ingress host configurations                        | `[]`                  |

### :floppy_disk: Databases

This section allows you to configure database-related settings.

| Key                                | Description                                                | Default               |
| ---------------------------------- | ---------------------------------------------------------- | --------------------- |
| `databases.enabled`                | Enable database-related deployments                        | `false`               |
| `postgres.enabled`                 | Enable the PostgreSQL deployment                           | `true`                |
| `postgres.image`                   | Image for the PostgreSQL deployment                        | `mamarbao/postgres:2.0`|
| `postgres.replicas`                | Number of replicas for the PostgreSQL deployment           | `1`                   |
| `postgres.secret.user`             | PostgreSQL user                                            | `mamarbao`            |
| `postgres.secret.password`         | PostgreSQL password                                        | `m4n56l.uc5`          |
| `postgres.secret.database`         | PostgreSQL database name                                   | `uc_5`                |

### :key: Service Account

This section allows you to configure service account settings.

| Key                                | Description                                                | Default               |
| ---------------------------------- | ---------------------------------------------------------- | --------------------- |
| `serviceAccount.create`            | Create a service account for the deployment                | `false`               |

### :notebook: ConfigMaps

This section allows you to configure ConfigMaps used by the deployed services.

| Key                                | Description                                                | Default               |
| ---------------------------------- | ---------------------------------------------------------- | --------------------- |
| `configmaps.goApi.enabled`         | Enable the ConfigMap for `goApi`                           | `true`                |
| `configmaps.goApi.data`            | Key-value pairs for the `goApi` ConfigMap                  | `{}`                  |
| `configmaps.fluentBit.enabled`     | Enable the ConfigMap for `fluentBit`                       | `true`                |
| `configmaps.goSimulator.enabled`   | Enable the ConfigMap for `goSimulator`                     | `true`                |
| `configmaps.goSimulator.data`      | Key-value pairs for the `goSimulator` ConfigMap            | `{}`                  |
| `configmaps.fluentBitSimulator.enabled` | Enable the ConfigMap for `fluentBitSimulator`           | `true`                |

## :test_tube: Running Tests

The chart includes a set of test connection Pods that are automatically created for each enabled service to verify connectivity.

To manually trigger the tests after deployment, use the following command:

```bash
helm

 test cloud-iot
```

This command will run the tests for all services that are enabled in the `values.yaml` file.

### :mag_right: Viewing Test Results

You can check the status of the test Pods using:

```bash
kubectl get pods -l "helm.sh/hook=test"
```

To view the logs of a specific test Pod:

```bash
kubectl logs <test-pod-name>
```

## :wastebasket: Uninstallation

To uninstall the Helm chart, use the following command:

```bash
helm uninstall cloud-iot
```

This command will remove all Kubernetes resources associated with the Helm release.

## :page_facing_up: Full Values Table

Here is a comprehensive table of all possible values and their descriptions.

(Include the detailed values table as previously)

## :lock: Secrets

### :closed_lock_with_key: Injecting Secrets Securely

- **CI/CD Environment Variables**: You can set environment variables in your CI/CD system and inject them during deployment using `--set` or by passing a separate secret values file.
- **Values File Encryption**: Consider using Helm plugins like [Helm Secrets](https://github.com/jkroepke/helm-secrets) to encrypt your values files, providing an additional layer of security for sensitive data.

### :closed_lock_with_key: Example Deployment Command with Secure Secrets

```bash
helm upgrade --install cloud-iot-chart ./cloud-iot-chart \
  --values values-prod.yaml \
  --set secrets.postgres.user=$POSTGRES_USER \
  --set secrets.postgres.password=$POSTGRES_PASSWORD \
  --set secrets.postgres.database=$POSTGRES_DB
```

## :microscope: Testing Your Chart

### :page_with_curl: Linting the Chart

Helm provides a built-in linting tool to check your chart for common issues:

```bash
helm lint
```

### :scroll: Template Rendering

You can render your Helm templates locally to see what the final Kubernetes YAML manifests will look like:

```bash
helm template my-chart/ --values my-values.yaml
```

### :hourglass_flowing_sand: Dry Run

Perform a dry run to simulate an installation:

```bash
helm install my-release my-chart/ --values my-values.yaml --dry-run --debug
```

### :clipboard: Validate Kubernetes Manifests

After rendering the templates with `helm template` or `helm install --dry-run`, you can pipe the output to `kubectl` to validate the resulting Kubernetes manifests:

```bash
helm template my-chart/ --values my-values.yaml | kubectl apply --dry-run=client -f -
```

### :link: Verify Dependencies

Ensure that your chart's dependencies are up to date:

```bash
helm dependency update my-chart/
```

### :white_check_mark: Check YAML Syntax

Use tools like `yamllint` to ensure that your YAML files are properly formatted:

```bash
yamllint my-chart/
```

### :heavy_check_mark: Unit Testing

Consider using tools like [helm-unittest](https://github.com/quintush/helm-unittest) to write unit tests for your Helm charts.

## :books: References

- [Helm Tips and Tricks](https://helm.sh/docs/howto/charts_tips_and_tricks/)
- [Helm Cheat Sheet](https://helm.sh/docs/intro/cheatsheet/)