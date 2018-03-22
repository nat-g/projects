## How to configure Nextcloud on Ubuntu.

Nextcloud is an open source, self-hosted file share and communication platform. 
You can access & sync your files, contacts, calendars & communicate and collaborate across your devices. 
You decide what happens with your data, where it is and who can access it.

Initial prerequisites: 
- Hosting environment with sudo access. In my case it's a VPS.
- Doman name or IP address.

### 1. Installing Nextcloud

To download and install the Nextcloud snap package:
```
$ sudo snap install nextcloud
```
You can confirm that the installation process was successful by listing the changes associated with the snap:
```
$ snap changes nextcloud
ID   Status  Spawn                 Ready                 Summary
2    Done    2018-03-22T05:52:15Z  2018-03-22T05:53:01Z  Install "nextcloud" snap
```
### 2. Configuring an Administrative Account

To configure Nextcloud with a new administrator account, use the nextcloud.manual-install command. 
You must pass in a username and a password as arguments:

```
$ sudo nextcloud.manual-install sammy password
The process control (PCNTL) extensions are required in case you want to interrupt long running commands - see http://php.net/manual/en/book.pcntl.php
Nextcloud is not installed - only a limited number of commands are available
Nextcloud was successfully installed
```
### 3. Adding the Trusted Domains

To view the current settings:
```
$ sudo nextcloud.occ config:system:get trusted_domains
The process control (PCNTL) extensions are required in case you want to interrupt long running commands - see http://php.net/manual/en/book.pcntl.php
localhost
```
We will be adding entry for a new domain with:
```
$ sudo nextcloud.occ config:system:set trusted_domains 1 --value=example.com
The process control (PCNTL) extensions are required in case you want to interrupt long running commands - see http://php.net/manual/en/book.pcntl.php
localhost
example.com
```
However you can add IP addresses as well by rerunning the config:system:set command

### 4. Securing Web Interface with SSL

There are two ways to do it: SSL with a Self-Signed Certificate or with the hepl of Let's Encrypt.
But since we have working domain name, I'll use Let's Encrypt.

First, open the ports in the firewall that Let's Encrypt uses to validate domain ownership:
```
$ sudo ufw allow 80,443/tcp
```
Second, request a Let's Encrypt certificate:
```
$ sudo nextcloud.enable-https lets-encrypt
In order for Let's Encrypt to verify that you actually own the
domain(s) for which you're requesting a certificate, there are a
number of requirements of which you need to be aware:

1. In order to register with the Let's Encrypt ACME server, you must
   agree to the currently-in-effect Subscriber Agreement located
   here:

       https://letsencrypt.org/repository/

   By continuing to use this tool you agree to these terms. Please
   cancel now if otherwise.

2. You must have the domain name(s) for which you want certificates
   pointing at the external IP address of this machine.

3. Both ports 80 and 443 on the external IP address of this machine
   must point to this machine (e.g. port forwarding might need to be
   setup on your router).

Have you met these requirements? (y/n): y
Please enter an email address (for urgent notices or key recovery): your_email@domain.com
Please enter your domain name(s) (space-separated): example.com
Attempting to obtain certificates... done
Restarting apache... done
```
### 5. Testing account

Access in a web browser https://example.com. Enter username and password of the administrative account that you created.
And observe this:

![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)
