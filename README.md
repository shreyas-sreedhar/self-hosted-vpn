# DigitalOcean OpenVPN Setup with Terraform

This project sets up an OpenVPN server on DigitalOcean using Terraform. It automates the creation of a DigitalOcean Droplet, installs OpenVPN, and configures the server.

## Prerequisites

Before you begin, make sure you have the following:

1. **Terraform** installed on your local machine.
2. **DigitalOcean API Token**: Create a personal access token from the DigitalOcean dashboard (https://cloud.digitalocean.com/account/api/tokens).
3. **SSH Key**: Make sure your SSH key is added to your DigitalOcean account to enable SSH access to the Droplet.

## Setup Steps

### 1. Clone this repository (if you haven't already):

```sh
git clone https://github.com/shreyas-sreedhar/self-hosted-vpn
cd self-hosted-vpn
```

### 2. Configure Terraform variables

Create a file named `terraform.tfvars` to store your sensitive data like API token and SSH key name. It should look like this:

```hcl
do_token      = "<your-digitalocean-api-token>"
ssh_key_name  = "<your-ssh-key-name>"
```

Replace the placeholder values with your actual DigitalOcean API token and the name of your SSH key.

### 3. Initialize Terraform

Run the following command to initialize the Terraform configuration:

```sh
terraform init
```

This will install the necessary Terraform provider (in this case, the DigitalOcean provider).

### 4. Apply the configuration

To create the droplet, apply the Terraform configuration:

```sh
terraform apply
```

Terraform will prompt you for confirmation before proceeding. Type `yes` to confirm.

### 5. Access the Droplet

Once Terraform finishes creating the droplet, it will output the IP address of your server:

```sh
Outputs:

server_ip = "<your-droplet-ip>"
```

You can use this IP to access your droplet and set up OpenVPN. For SSH access:

```sh
ssh root@<your-droplet-ip> -i <path-to-your-ssh-key>
```

### 6. VPN Setup

The droplet is created with OpenVPN pre-installed (using the `openvpn-18-04` image). To configure OpenVPN, you'll need to follow these steps on the Droplet:

1. SSH into the Droplet using the command above.
2. Follow the OpenVPN setup guide for Ubuntu to complete the server configuration.
3. Generate client configuration files for use with OpenVPN clients.

Refer to the [OpenVPN Community Guide](https://openvpn.net/community-resources/) for more details.

### 7. Cleanup

Once you're done, you can destroy the resources to avoid unnecessary charges by running:

```sh
terraform destroy
```

This will tear down the droplet and any associated resources.

## Troubleshooting

- **Invalid SSH key**: If you encounter an error related to the SSH key, ensure that your SSH key is correctly added to your DigitalOcean account and that the key name in `terraform.tfvars` matches the one in your DigitalOcean account.
- **API Token issues**: If you get errors related to the API token, verify that the token is correct and has the appropriate permissions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
