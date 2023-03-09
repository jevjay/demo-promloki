# Can Nagios be integrated with Prometheus?

Yes, Nagios can be integrated with Prometheus using a tool called 'Prometheus [Exporter](https://github.com/m-lab/prometheus-nagios-exporter) for Nagios'. It is an open-source software that extracts performance data from the Nagios plugin output and exports it in Prometheus-compatible format.

By using this integration, Nagios users will be able to leverage the powerful metrics collection, querying, and alerting capabilities provided by Prometheus. This allows for more advanced monitoring and alerting workflows than what is available with Nagios alone.

However, it's important to note that while this integration provides valuable benefits, it requires additional setup and maintenance effort compared to using Nagios or Prometheus independently. Additionally, since Nagios is not natively built to be used with Prometheus, there may be limitations in how the data can be processed and visualized within the Prometheus ecosystem.

## Notes

Such integration provides a great benefit in a short-term allowing organisation to quickly onboard legacy monitoring onto Prometheus, but we discourage using it in the long-term as it creates following disadvantages:

- Fragmentation of monitoring architecture
- Increase in monitoring management task which can lead with a number of issues
- Split of responsibilities for solutions
