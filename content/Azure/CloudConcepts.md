---
title: "Cloud Concepts"
date: 2022-12-23T16:31:23+01:00
draft: false
---

## Definition

- Delivery of computing services over the internet (common IT infrastructure such as virtual machines, storage, databases, and networking). 
- Cloud services also expand the traditional IT offerings to include things like Internet of Things (IoT), machine learning (ML), and artificial intelligence (AI).
- It allows to move capital expenditure (servers, datacenters, etc) into operational expenditure (cloud costs).

## Benefits
- __High availability__: Always available (SLA)
- __Scalability__: 
  - Vertical: Ease to add more power to machines
  - Horizontal: Ease to add more machines
- __Reliability__: Decentralized, globally distributed
- __Predictability__:  Constant performance and costs
- __Security__: Different levels of access, built in protection
- __Governance__: Ease to implement compliance
- __Manageability__: Ease to add/delete resources and interact with infrastructure

## Models

3 different models:

- **Public Cloud**: 
  - Build controlled and maintained by a third party
  - Available to the public
- **Hybrid Cloud**:
  - Use private and public clouds interconnected
- **Private Cloud**: 
  - Cloud used by a single entity
  - On premises
  - Offers total control
  - More cost and complexity

## Service Types:

Cloud providers distinguish 3 types of service. Each service place responsibility to the provider or the customer side (Shared responsibility model). These are:

- **IaaS**: 
  - Infrastructure as a service
  - Most responsibility to the customer
  - Provider maintains and manages physical infrastructure
  - Examples include VM services, virtual networks, etc.
- **PaaS**
  - Platform as a service
  - Middleground
  - Provider additionally maintains OS, dev tools, etc.
  - Examples like Azure app services, AKS
- **SaaS**
  - Software as a service
  - Complete managed solution
  - Examples include Managed dbs

The different responsibilities for each service type are shown below

![srm](/images/Azure/srm.png)