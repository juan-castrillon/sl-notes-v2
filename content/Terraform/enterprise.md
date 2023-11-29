---
title: "Terraform Enterprise"
date: 2023-11-21T17:57:09+01:00
draft: true
---


Terraform enterprise is a self-hosted version of Terraform Cloud. It offers enterprise-grade features such as audit logging, SAML SSO, and role-based access control.

It requires a license and can be installed on-premises or in the cloud.

## Requirements

They depend on the operational mode (how data should be stored):

- **External services mode**: Requires a PostgreSQL database and a storage bucket (S3, GCS, Azure Blob Storage, etc).
- **Mounted disk mode**: Requires a mounted disk (NFS, EFS, etc).
- **Demo mode**: Stores data in the instance. Not recommended for production.

System requirements vary, but some recommendations are:
- At least 4 CPU cores
- At least 8GB of RAM
- At least 50GB of disk space (40 for docker data and 10 for the application)

> Terraform enterprise also supports installation on air-gapped environments. This does not require internet access and can be used to install Terraform Enterprise on a private network.