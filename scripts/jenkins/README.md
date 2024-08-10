# Install Jenking


# Config Jenkins

```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

# Generate SSH

```bash
    ssh-keygen -t rsa -b 4096 -C "jenkins@luis122448.com"
```

# Review and Copy to Github/GitLab

```bash
    sudo cat /home/developer-user/.ssh/id_rsa.pub
```

# Testing connection

```bash
    sudo ssh -T git@github.com:luis122448/smart-shell-angular.git
```

# Login de jenkins user

```bash
    sudo su - jenkins
```

# Config SSH connection for GitHub
## /root/.ssh/id_ed25519
## /root/.ssh/id_ed25519.pub

```bash
    sudo ssh-keygen -t ed25519 -C "luis122448@gmail.com"
```

# Review SSH Keys

```bash
    ls /var/lib/jenkins/.ssh/
```

# Opem and copy public key, for Github

```bash
    cat /var/lib/jenkins/.ssh/id_ed25519.pub
```

# Cahnge user

```bash
    sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/id_ed25519
    sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/id_ed25519.pub
    sudo chmod 600 /var/lib/jenkins/.ssh/id_ed25519
    sudo chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub
```

# Add ssh keyu a GitHub

```bash
    sudo -u jenkins ssh-keyscan -t ed25519 github.com | sudo tee -a /var/lib/jenkins/.ssh/known_hosts
```

# Test connection

```bash
    sudo -u jenkins ssh -T git@github.com
```
# Hi luis122448! You've successfully authenticated, but GitHub does not provide shell access.


# Configure Jenkins credentials

```bash
    cat /var/lib/jenkins/.ssh/id_ed25519
```

# Install Docker and Docker Pipelined plugins


# Integracion con docker

```bash
    sudo usermod -aG docker jenkins
```

# Restar Jenkins

```bash
    sudo systemctl restart jenkins
```