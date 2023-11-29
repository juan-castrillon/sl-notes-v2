---
title: "IaC Concepts"
date: 2023-03-08T17:47:21+01:00
draft: true
---

# What is infrastructure as code (IaC)
- Writing configuration (in the form of a script) to automate
  - creation
  - update
  - destruction
of cloud infra

- Allows to share, version and inventory infra

- Manually creating infra is error prone, time consuming and not repeatable. 

# popular iac tools
- two types
  - Declarative
    - What you see is what you get
    - Explicit
    - Scripting language json yaml, hcl
    - No misconfiguration
      - ARM Templates
      - Azure Blueprints
      - CloudFormation
      - Terraform
  - Imperative
    - Say what you want the rest is filled in
    - Implicit
    - Less verbose
    - Programming languages
      - CDK AWS
      - pulumi

With an imperative tool, you define the steps to execute in order to reach the desired solution. With a declarative tool, you define the desired state of the final solution, and the automation platform determines how to achieve that state.

# Infrastrcuture Lifecycle
Concept of having clearly defined and distinct work phases which are used by DevOps Engineers to plan, design, build, test, and deliver, maintain and retire cloud infrastructure.

Commonly used Day0 (plan/design), DAy1(develop/iterate/test), Day2(live deployment, maintenance)

IaC brings into the lc: 
reliabiliy
    idempotent 
        (always same result)
        ![](/images/Terraform/idempotent.png)
    consistent
    predictable
manageability
    reviews
    versions

# prov, deploy, orchestration
provisioning: prepare a server with data, software to make it "ready"
deployment: putting an application on a prepared server
orchestration:: mostly related to containers, coordinating deployments

# drift
provisioned infra has a configuration different from the state
can be caused by:
    manual config changes
    malicious actors
    errors
detect:
    cloud provider tools like Azure policy
    using terraforms state as a base to compare
fix:
    remediation in provider tools
    terraform `apply -refresh-only` and `plan` commands
    manually making the states equal
prevent:
    Immutable infrastructure, always create and destroy, never reuse, Blue, Green deployment strategy.​
    GitOps

https://developer.hashicorp.com/terraform/tutorials/state/resource-drift

# GitOps

- Git repo for IaC
- Review and accept changes
- Trigger deploy

# Immutable infrastructure

- using something like packer to guarantee configuration
- makes resilent against:
  - cloud resource failures
  - region failures
  - Makes deployment quicker and repeatable (one to one guarantee in all machines, no different versions of dependencies)