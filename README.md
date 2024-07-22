In this project, we'll walk you through setting up a Ghost blog using Vagrant, Docker, and Apache on a Debian-based virtual machine. This setup allows for an easily reproducible development environment.

### Directory Structure

```
.
├── data
│   ├── docker-compose.yml
│   └── example.site.conf
├── scripts
│   └── provision.sh
└── Vagrantfile
```

### Content:

- Vagrantfile
- Provisioning Script
- Docker Compose Configuration
- Apache Virtual Host Configuration

### Updating the Hosts File

To access the Ghost blog using `http://example.site`, you'll need to update your host machine's hosts file. Add the following line, replacing 192.168.0.X with the actual IP address of your Vagrant machine:

```
192.168.0.X example.site
```

On Unix-based systems, this file is located at `/etc/hosts`, and on Windows, it's located at `C:\Windows\System32\drivers\etc\hosts`.

### Bringing Up the Environment

With all the configurations in place, you can now bring up the Vagrant environment:

```
vagrant up
```

This command will create and configure the VM, install Docker and Apache, and set up the Ghost blog using Docker Compose.

### Accessing Your Ghost Blog

Once the VM is up and running, you can access your Ghost blog at `http://example.site`. If your network configuration is correct, this should resolve to your Vagrant machine's IP address.
