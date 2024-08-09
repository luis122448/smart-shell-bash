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