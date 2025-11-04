# 🐳 DevOps Guide (Docker/Kubernetes/YAML)

Complete guide for DevOps tools.

---

## Setup

### Language Servers
- **dockerls** - Dockerfile
- **yamlls** - YAML (with Kubernetes schemas)

Auto-installed via Mason.

---

## Docker

### Dockerfile Support

**Features**:
- Instruction completion
- FROM suggestions
- Syntax validation
- Best practice hints

**Example**:
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### Docker Commands

```bash
# Build
docker build -t myapp .

# Run
docker run -p 3000:3000 myapp

# Compose
docker-compose up -d
```

In Neovim:
```vim
:!docker build -t myapp .
:TermExec cmd="docker-compose up"
```

---

## Kubernetes

### YAML Support

Auto-completion for:
- Kubernetes resources
- API versions
- Field names
- Enum values

**deployment.yaml**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:latest
        ports:
        - containerPort: 3000
```

### kubectl Commands

```bash
# Apply
kubectl apply -f deployment.yaml

# Get resources
kubectl get pods

# Logs
kubectl logs pod-name
```

In Neovim:
```vim
:!kubectl apply -f %
:!kubectl get pods
```

---

## Helm Charts

Auto-completion for:
- Chart.yaml
- values.yaml
- Templates

---

## Docker Compose

**docker-compose.yml**:
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=secret
```

Commands:
```bash
docker-compose up -d
docker-compose logs -f
docker-compose down
```

---

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)
