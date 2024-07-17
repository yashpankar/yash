# Helm Chart Templates for scheduler Application deploying  in Kubernetes

### This project provides template Helm Charts for deploying  scheduler application on Kubernetes .
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



#### In order to use these template files, copy the files from this project into your application directory. 
#### You should only need to edit the Chart.yaml and values.yaml files.



##  Adding the Chart to your Application

 ####   In order to add Helm Charts to your application,  copy the charts directory from this project into your application's root directory  You then need to make a single change before the charts are usable:  to set the image.repository for your application.

   ### Setting the following parameter 
    

  ####  The following table lists the configurable parameters of the template Helm chart and their default values. 

| Parameter               | Description                                |Default   |
| ----------------------- | ------------------------------------------ | --------- |
| namespace               | Namespace for deployment                   | default   |
| entryPointCommand       | specific command to always run when the container starts |- python \               
/home/process-scheduler/code/main.py  
| Replicacount            | For availability                           | 2         |
| nameOverride            |replaces the name of the chart in the Chart.yaml file | scheduler
|fullnameOverride         | completely replaces the generated name  | process-scheduler
| image.pullPolicy        | Image pull policy                          | Always    |
| image.repository        | image repository                           |   {PROD_ACR_LOGIN_SERVER}/${REPO_NAME}      |
| image.tag               | Image tag                                  | latest    |
| resources.limits.cpu    | CPU resource limits                        | 50m       |
| resources.limits.memory | Memory resource limits                     | 100Mi     |
| resources.requests.cpu  | CPU resource request                 			| 50m
| resources.requests.memory|Memory resource request | 100MI |
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


  ####  The Following table lists the  configurable Environment Variables 

| KEY                                       | VALUE                                              |
| ----------------------------------------- | -------------------------------------------------- |
| envVars. DOWNSTREAM_LIMIT                 | 200000                                             |
| envVars.ABORTED_OPTIMIZER_STREAM          | aborted-optimizer-01                               |
| envVars.ABORTED_TRAIN_STREAM              | aborted-train-01                                   |
| envVars.DOWNSTREAM_MAX_LEN                | 100000                                             |
| envVars.LIVENESS_CHECK_BINARY             | "/home/process-scheduler/code/livenesscheckserver" |
| envVars.LIVENESS_CHECK_FILE               | "/home/process-scheduler/liveness.txt"             |
| envVars.LIVENESS_CHECK_PORT               | "8501"                                             |
| envVars.MAX_NEW_MESSAGES                  | 300                                                |
| envVars.MAX_PENDING_MESSAGES              | 1000                                               |
| envVars.METRICS_PORT                      | 8000                                               |
| envVars.OPTIMIZER_STREAM                  | optimizer-01                                       |
| envVars.PRIMARY_STREAM                    | primary-process-stream                             |
| envVars.REDIS_HOST                        | redis.redis.svc.cluster.local                      |
| envVars.REDIS_UNCONSUMED_BUILDING_IDS_KEY | unconsumed_bid                                     |
| envVars.REST_PERIOD                       | "15"                                               |
| envVars.SCHEDULER_CG_NAME                 | scheduler                                          |
| envVars.SENTINEL_MASTER_SET_NAME          | mymaster                                           |
| envVars.SENTINEL_PORT                     | "26379"                                            |
| envVars.TRAIN_STREAM                      | train-01                                           |

#### you can add environment variables at the time of apply by this command

```
helm -n $PROD_NAMESPACE upgrade --install \
--set env.<key1>=<value1> --set env.<key2>=<value2> \
--set image.repository=${PROD_ACR_LOGIN_SERVER}/${REPO_NAME}\
--set image.tag=${MAJOR_VERSION}.${BUILD_NUMBER} \
RELEASE_NAME $CHART_DIR -f $PROD_VALUES
```

  


## Using the Chart to deploy your Application to Kubernetes


#### In order to use the Helm chart to deploy and verify your application in Kubernetes, run the following commands:

1. From the directory containing Chart.yaml, run:
     Helm 
    
    
```
helm -n $PROD_NAMESPACE upgrade --install \
--set image.repository=${PROD_ACR_LOGIN_SERVER}/${REPO_NAME}\
--set image.tag=${MAJOR_VERSION}.${BUILD_NUMBER} \
$RELEASE_NAME $CHART_DIR -f $PROD_VALUES
```



 This deploys and runs your application in Kubernetes, and prints the following text to the console:
 
 Congratulations, you have deployed your  Application to Kubernetes using Helm!
 

2. To verify your application is running, run the following  commands 
    ` kubectl get pod --namespace default -o json `
    `kubectl get svc --namespace default -o json`
`kubectl get configmap --namespace default -o json`


3) Uninstalling your Application
     Helm 
    ```
    helm uninstall <RELEASE_NAME> 
    ```
