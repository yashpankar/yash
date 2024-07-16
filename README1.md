# Helm Chart Templates for Metric-Exporter Application deploying  in Kubernetes

### This project provides template Helm Charts for deploying  Metric-Exporter application on Kubernetes .
### The templates require your application to built into a Docker image. 
#### This helm chart Deploy by jenkins

**This project provides the following files:**
| File                                                 | Description                                                             |
| ---------------------------------------------------- | ----------------------------------------------------------------------- |
| _helpers.tpl                               | Contains helper templates that define reusable template snippets        |
| configmap.yaml                             | Template for the ConfigMap resource                                     |
|deployment.yaml                            | Template to configure your application deployment.                      |
|service.yaml                               | Template for the Service resource.                                      |
| serviceaccount.yaml                        | Template for the ServiceAccount resource.                               |
| servicemonitors.monitoring.coreos.com.yaml | Template to configure your application deployment.                      |






#### In order to use these template files, copy the files from this project into your application directory. 
#### You should only need to edit the Chart.yaml and values.yaml files.

#

##  Adding the Chart to your Application

 ####   In order to add Helm Charts to your application,  copy the charts directory from this project into your application's root directory  You then need to make a single change before the charts are usable:  to set the image.repository for your application.

   ### Setting the following parameter 
    

  ####  The following table lists the configurable parameters of the template Helm chart and their default values. 

| Parameter               | Description                                |Default   |
| ----------------------- | ------------------------------------------ | --------- |
| namespace               | Namespace for deployment                   | default   |
| entryPointCommand       | specific command to always run when the container starts |- python / /home/queumonitor/code/main.py 
| Replicacount            | For availability                           | 2         |
| nameOverride            |replaces the name of the chart in the Chart.yaml file | metric-exporter
|fullnameOverride         | completely replaces the generated name  | stream-metric-exporter
| image.pullPolicy        | Image pull policy                          | Always    |
| image.repository        | image repository                           |   repository.image.tag      |
| image.tag               | Image tag                                  | latest    |
| resources.limits.cpu    | CPU resource limits                        | 50m       |
| resources.limits.memory | Memory resource limits                     | 100Mi     |
| resources.requests.cpu  | CPU resource request                 			| 50m
| resources.requests.memory|Memory resource request | 100MI 
|
| service.port            | TCP Port for this service                  | 8000      |
| service.type            | Kubernetes service type exposing port      | ClusterIP |
|   securityContext.runAsuser             | which user do you want to run in container | 1000      |
|  securityContext.runAsNonRoot           | if don't want to use root user       | true 
| securityContext.readOnlyRootFilesystem  | Readonly permission of root file system | false
|nodeSelector.agentpool | for node selector | default 
| podSecurityContext.fsGroup | specifies the POSIX group ID applied to all volumes in a pod | 2000
|livenesscheck.port          | Livenesscheck port for health check | 8501
|livenesscheck.path          |Livenesscheck path for health check | /healthz
|livenesscheck.initialDelaySeconds | giving the application time to initialize | 30
|livenesscheck.path.failureThreshold | if at least this number of probes have failed | 5
|livenesscheck.periodSeconds   | specifies the interval to wait between liveness probe checks | 30


  ####  The Following table lists are  configurable Environment Variables 
  
| KEY                                   | VALUE                                     |
| ------------------------------------- | ----------------------------------------- |
| envVars. METRICS_PORT                 | 8000                                      |
| envVars.LIVENESS_CHECK_BINARY         | /home/quemonitor/code/livenesscheckserver |
| envVars.LIVENESS_CHECK_FILE           | /home/quemonitor/code/liveness.txt        |
| envVars.LIVENESS_CHECK_PORT           | 8501                                      |
| envVars.MAX_MSG_COUNT_PER_REQUEST     | 500                                       |
| envVars.METRIC_PREFIX                 | stage                                     |
| envVars.OPTIMIZER_ABORTED_QUEUE       | stage-aborted-optimizer-01                |
| envVars.OPTIMIZER_CG                  | stage -optimizer-cg-01                    |
| envVars.OPTIMIZER_QUEUE               | stage -optimizer-01                       |
| envVars.REDIS_HOST                    | redis.redis.svc.cluster.local             |
| envVars.REDIS_KEY_UNCONSUMED_BID_HMAP | stage-unconsumed_bid                      |
| envVars.SENTINEL_MASTER_SET_NAME      | mymaster                                  |
| envVars.SENTINEL_PORT                 | 26379                                     |
| envVars.TRAIN_ABORTED_QUEUE           | stage-aborted-train-01                    |
| envVars.TRAIN_CG                      | stage-train-cg-01                         |
| envVars.TRAIN_QUEUE                   | stage-train-01                            |

   


## Using the Chart to deploy your Application to Kubernetes


#### In order to use the Helm chart to deploy and verify your application in Kubernetes, run the following commands:

1. From the directory containing Chart.yaml, run:
     Helm 
    

`helm -n <namespace> --install <release_name> <Chart_Dir>`



 This deploys and runs your application in Kubernetes, and prints the following text to the console:
 Congratulations, you have deployed your  Application to Kubernetes using Helm!

2. To verify your application is running, run the following  commands 
    ` kubectl get pod --namespace default -o json `
    `kubectl get svc --namespace default -o json`
`kubectl get configmap --namespace default -o json`


3) Uninstalling your Application
     Helm 
    ` helm install <Realease_name> `.
