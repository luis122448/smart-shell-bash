# Docs
# https://ongkhaiwei.medium.com/generate-lets-encrypt-certificate-with-dns-challenge-and-namecheap-e5999a040708

# Install Let’s Encrypt Certbot 
sudo apt install certbot

# Generate new certificate using Certbot
The command to generate the cert is relatively simple. You can do for single domain, for multiple domains then just needs to append -d DOMAIN. In this case I used *.DOMAIN so that the certificate can be used for subdomain as well. The wizard will ask for a few simple information.

```bash
sudo certbot certonly --manual --preferred-challenges dns -d "luis122448.com" -d "*.luis122448.com"
sudo certbot certonly --manual --preferred-challenges dns -d "luis122448.dev" -d "*.luis122448.dev"
```

Please deploy a DNS TXT record under the name:

_acme-challenge.luis122448.dev.

with the following value:

NchJD9OugQF3zt8mEk9NfqfgmDL8yKdYM6a5mfT2dLU

# Setting DNX TXT ACME Challenge in Namecheap
Once Y is entered in the previous step, Certbot will revert with ACME challenge token to be configured in DNS provider to allow verification. Copy the token and insert as TXT record in DNS console of Namecheap.

# - - - - - - - - - - - 
# Register in namecheap 
# - - - - - - - - - - -
# Please deploy a DNS TXT record under the name:
# _acme-challenge.smart-shell [_acme-challenge.smart-shell.luis122448.com]
# with the following value:
# hy1dKKwwbWyGSDKwdTTFePA7ulN8RuphbOAH051Af90

# Verify TXT record 
Please set TTL to 1 minute to allow Top-level DNS servers to pick up this new subdomain — _acme-challenge.DOMAIN. You can verify this DNS TXT record using nslookup before proceed with verification.

```bash
    nslookup -type=TXT _acme-challenge.luis122448.com
```

# Verify the domain challenge
Press Enter and Certbot will continue with the verification process.

# - - - - - -
# Successfully 
# - - - - - -
# Successfully received certificate.
# Certificate is saved at: /etc/letsencrypt/live/smart-shell.luis122448.com/fullchain.pem
# Key is saved at:         /etc/letsencrypt/live/smart-shell.luis122448.com/privkey.pem
# This certificate expires on 2024-10-21.

# Retrieve the certificate
You will hit permission error when trying to retrieve the file. This is due to folder permission of /etc/letsencrypt/liveis set to root. Therefore we can set permission to allow other users to read via sudo chmod +x /etc/letsencrypt/live

```bash
    sudo chmod +x /etc/letsencrypt/live
```