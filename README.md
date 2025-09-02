

## What is this guide about?

This guide is to have Terraform Enterprise running with Docker and test Terraform Enterprise system api.

Learn about Terraform Enterprise system api:
https://developer.hashicorp.com/terraform/enterprise/api-docs/ping#system-api-overview

## Prerequisites 

- Account on AWS Cloud

- AWS IAM user with permissions to use AWS EC2 and AWS Route53

- A DNS zone hosted on AWS Route53

- Terraform Enterprise Docker license

- Git installed and configured on your computer

- Terraform installed on your computer

## Create the AWS resources and start TFE

Export your AWS access key and secret access key as environment variables:
```
export AWS_ACCESS_KEY_ID=<your_access_key_id>
```

```
export AWS_SECRET_ACCESS_KEY=<your_secret_key>
```


Clone the repository to your computer.

Open your cli and run:
```
git clone git@github.com:StamatisChr/TFE-FDO-docker-test-system-api.git
```


When the repository cloning is finished, change directory to the repo’s terraform directory:
```
cd TFE-FDO-docker-test-system-api
```

Here you need to create a `variables.auto.tfvars` file with your specifications. Use the example tfvars file.

Rename the example file:
```
cp variables.auto.tfvars.example variables.auto.tfvars
```
Edit the file:
```
vim variables.auto.tfvars
```

```
# example tfvars file
# do not change the variable names on the left column
# replace only the values in the "< >" placeholders

tfe_instance_type             = "<aws_ec2_instance_type>" # Set here the EC2 instance type only architecture x86_64 is supported, example: m5.xlarge
hosted_zone_name              = "<dns_zone_name>"         # your AWS route53 DNS zone name
tfe_license                   = "<tfe_license_string>"    # TFE license string
tfe_version_image             = "<tfe_version>"           # desired TFE version for podman, should be v202505-1 or higher
```


To populate the file according to the file comments and save.

Initialize terraform, run:
```
terraform init
```

Create the resources with terraform, run:
```
terraform apply
```
review the terraform plan.

Type yes when prompted with:
```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 
```
Wait until you see the apply completed message and the output values. 

Example:
```
Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

admin_password = <sensitive>
admin_username = "admin"
systemapicall = <<EOT
      curl -s \
      --header "Authorization: Bearer $TOKEN" \
      --request GET https://cuddly-pig.stamatios-chrysinas.sbx.hashidemos.io:8443/api/v1/ping | jq

EOT
tfe_url = "https://cuddly-pig.stamatios-chrysinas.sbx.hashidemos.io"

```

- Wait about 7-8 minutes for Terraform Enterprise to initialize.


## Get the admin api token
This method to get the admin api token is a workaround and works only for this example.

Learn more on how to generate an admin api token:
https://developer.hashicorp.com/terraform/enterprise/deploy/reference/cli#generate-an-admin-api-token

- Get the admin user password, run:
```
terraform output admin_password
```
- Use the `tfe_url` output value to visit TFE login page

- Use the admin_username and admin_password output values to login to TFE

- Navigate to TFE org and then to the TFE workspace

The workspace name is the admin api token.

- Copy the workspace name, it's easier if you copy it from the URL.

Example URL, the admin api token is the value after `workspaces/`
```
https://cuddly-pig.stamatios-chrysinas.sbx.hashidemos.io/app/my-org/workspaces/14626xxxa975e0bb56a3b39473c0ca615e0f6c4294ff8cd5969acb14a577da5e
```

## Make the system api call

- Export the token:
```
export TOKEN="14626xxxa975e0bb56a3b39473c0ca615e0f6c4294ff8cd5969acb14a577da5e"
```

- Run the command from terraform output with name `systemapicall`

```
curl -s \
 --header "Authorization: Bearer $TOKEN" \
 --request GET https://cuddly-pig.stamatios-chrysinas.sbx.hashidemos.io:8443/api/v1/ping | jq
```

Output:
```
"pong"
```

## Clean up

To delete all the resources, run:
```
terraform destroy
```
type yes when prompted.

Wait for the resource deletion.
```
Destroy complete! Resources: 13 destroyed.
```

Done.