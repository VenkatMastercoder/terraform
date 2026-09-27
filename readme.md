# Terraform

Topics covered in this class, mapped to `day_1`, `day_2`, and `day_3`.

## Day 1 — Terraform basics (`day_1`)

- Terraform block (`required_providers`) and AWS provider
- Provider region (`ap-south-2`)
- First resources: `aws_s3_bucket` and `aws_instance`
- Hardcoded values (bucket name, AMI, instance type, tags)
- Local state after `terraform init` / `plan` / `apply`

## Day 2 — Variables, outputs, and AWS resources (`day_2`)

### File split

- Separate files: `provider.tf`, `variable.tf`, resource files, `output.tf`, `terraform.tfvars`

### Variables and outputs

- `variable` with type and default
- Override defaults with `terraform.tfvars`
- `output` of resource IDs, ARNs, and names (`var.` usage)

### EC2 (`terraform_ec2`)

- Multiple EC2 instances (Ubuntu, Windows, Red Hat AMIs)
- Shared `instance_type` variable

### S3 (`terraform_s3`)

- S3 bucket from a variable
- Output bucket name

### VPC networking (`terraform_vpc`)

- VPC, public subnet, Internet Gateway
- Route table and subnet association
- Security group (HTTP, HTTPS, SSH ingress; all egress)
- EC2 in the VPC subnet with the security group
- Resource interpolation (`aws_vpc.main.id`, etc.)

## Day 3 — State, workspaces, and modules (`day_3`)

### Remote state (`terraform_state`)

- S3 backend (`backend "s3"`)
- Remote `terraform.tfstate` (`key`, region, encrypt)
- Native S3 state locking (`use_lockfile`)
- DynamoDB table for state locking (`LockID`)
- S3 bucket used as the state store (`force_destroy`)

### Workspaces (`terraform_workspace`)

- Terraform workspaces for environments (`dev`, `prod`)
- Per-workspace state under `terraform.tfstate.d/`

### Modules (`terraform_modules`)

- Local modules (`source = "./modules/..."`)
- Module structure: `main.tf`, `variables.tf`, `output.tf`
- Reusable S3 and EC2 modules
- Calling the same module more than once (two S3 buckets)
- VPC module layout (VPC, subnet, IGW, routes, SG, EC2)
