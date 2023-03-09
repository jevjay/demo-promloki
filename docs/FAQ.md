# FAQ

## The most optimal storage solution for Prometheus and Loki which is cost-effective

Prometheus is designed to use local disk storage for short-term storage, while long-term storage requires additional tools such as remote storage adapters like Thanos or using an object storage system like Amazon S3, Google Cloud Storage, and Microsoft Azure Storage. These cloud object storage options are generally considered to be the most cost-effective storage solutions for Prometheus.

Loki, on the other hand, has native support for various object stores, including Amazon S3, Google Cloud Storage, and Azure Storage, as well as self-hosted storage solutions like OpenStack Swift and Ceph. These storage options provide a cost-effective way to store and analyze large volumes of unstructured log data.

## Is it possible to run Prometheus & Loki in HA?

Yes, but both have a number of differences. In order to run **Prometheus** and Loki in a highly available setup, you will need to implement a cluster architecture. Here are the general steps you can follow:

### Use a Load Balancer
To distribute traffic across multiple instances of your services, you will need to use a load balancer. You can use an external load balancer such as Kubernetes or the built-in mechanisms within the services themselves.

### Set up a Cluster Manager
Prometheus and Loki each have different options for cluster management, depending on the use case. For Prometheus, there are several implementations of cluster management:

1. Thanos: implements high availability for Prometheus by creating a global view of metrics.
2. Cortex: runs several instances of Prometheus behind a common ingest layer.
3. Federation: is an experimental feature that allows multiple Prometheus servers to scrape the same targets and share data between them.

For **Loki**, the recommended solution is running multiple replicas in a cluster using Kubernetes StatefulSets.

### Configure Storage
Both Prometheus and Loki require persistent storage to function optimally in a HA environment. You can configure each service to use an external database such as Cassandra, Bigtable, or Google Cloud Storage. Alternatively, you can define the local storage directories as network drives that can be mounted by multiple containers.

### Replicate Data
To ensure high availability of data, you should replicate both Prometheus and Loki endpoints. In the event of a failure or loss of data, replicated endpoints will have copies of the data which can replace the failed instance.

### Monitor Your Services
Lastly, it's important to monitor your Prometheus and Loki instances to quickly identify any potential issues before they become critical. This can be done using a number of open-source tools that provide alerts, visualization, and historical data analysis.

By following these steps, you can set up a highly available infrastructure that ensures continuous availability of critical backend services such as Prometheus and Loki.
