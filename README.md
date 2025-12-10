# Starlight - Dockerized Web Application

A simple containerized web application using Nginx and Docker deployed on Azure Kubernetes Service (AKS).

## Prerequisites

- Docker installed on your machine
- Docker Hub account
- kubectl installed and configured
- Azure CLI installed
- Connected to your AKS cluster

## Project Structure

```
starlight/
├── dockerfile
├── index.html
├── nginx.conf
├── namespace.yaml
├── deployment.yaml
├── service.yaml
├── ingress.yaml
├── letsencrypt-issuer.yaml
└── README.md
```

## Step-by-Step Guide

### Step 1: Clean Up Existing Containers

Remove any existing containers with the same name:

```bash
docker rm -f 2nitestarlight starlight-test
```

### Step 2: Build the Docker Image

Navigate to the project directory and build the image:

```bash
cd /Users/linaaljanabi/playground/starlight
docker build -t kayboadist/starlight:latest .
```

**What this does:**
- Reads the dockerfile
- Creates a Docker image based on `nginx:alpine`
- Copies index.html into the container
- Configures nginx with the custom configuration
- Tags it as `kayboadist/starlight:latest`

### Step 3: Test Locally

Run the container locally to test before pushing:

```bash
docker run -d -p 8080:80 --name starlight-test kayboadist/starlight:latest
```

Then visit `http://localhost:8080` in your browser to see the app.

**Stop and remove the test container:**

```bash
docker stop starlight-test
docker rm starlight-test
```

### Step 4: Login to Docker Hub

```bash
docker login
```

Enter your Docker Hub username and password when prompted.

### Step 5: Push to Docker Hub

```bash
docker push kayboadist/starlight:latest
```

**Expected output:**
```
The push refers to repository [docker.io/kayboadist/starlight]
latest: digest: sha256:... size: ...
```

### Step 6: Verify on Docker Hub

Visit `https://hub.docker.com/r/kayboadist/starlight` to confirm your image is uploaded.

### Step 7: Deploy to Kubernetes

Ensure your Kubernetes manifests are created and apply them:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

### Step 8: Verify Kubernetes Deployment

```bash
# Check deployment status
kubectl get deployments -n starlight

# Check pods
kubectl get pods -n starlight

# Check service
kubectl get svc -n starlight

# Check ingress
kubectl get ingress -n starlight
```

### Step 9: Access Your Application

Visit your domain: `http://starlight.2nitestarlight.ca`

## Troubleshooting

**Port already in use:**
```bash
docker run -d -p 9000:80 --name starlight-test kayboadist/starlight:latest
# Visit http://localhost:9000
```

**Container name already exists:**
```bash
docker rm -f 2nitestarlight
```

**Image not found on Docker Hub:**
- Make sure you logged in: `docker login`
- Verify image was pushed: `docker push kayboadist/starlight:latest`
- Verify image exists: `docker images | grep starlight`

**Kubernetes pod shows ImagePullBackOff:**
- Check if image exists on Docker Hub
- Verify deployment has correct image name in `deployment.yaml`
- Restart deployment: `kubectl rollout restart deployment/starlight-deployment -n starlight`

**404 Error in browser:**
- Check if pods are running: `kubectl get pods -n starlight`
- Check pod logs: `kubectl logs -n starlight <pod-name>`
- Verify service selector matches deployment labels: `kubectl get pods -n starlight --show-labels`

## Useful Commands

```bash
# Docker commands
docker ps                                    # View running containers
docker images                                # View all images
docker logs <container-name>                # View container logs
docker stop <container-name>                # Stop container
docker rm <container-name>                  # Remove container
docker rmi kayboadist/starlight:latest      # Remove image

# Kubernetes commands
kubectl get pods -n starlight               # View pods
kubectl get svc -n starlight                # View services
kubectl get ingress -n starlight            # View ingress
kubectl describe pod <pod-name> -n starlight # Pod details
kubectl logs <pod-name> -n starlight        # Pod logs
kubectl port-forward -n starlight <pod-name> 8080:80  # Port forward
kubectl rollout restart deployment/starlight-deployment -n starlight  # Restart deployment
```

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [AKS Documentation](https://learn.microsoft.com/en-us/azure/aks/)
