---
title: "Basics"
date: 2023-03-30T18:27:02+02:00
draft: true
---


terraform is an open source and cloud agnostic tool
declarative
files written in hcl


## terraform cloud
saas
remote state storage
vc integration
workflows
collaboration on changes

# lifecycle
1. write terraform code
2. init (get dependencies)
3. plan (dry run)
4. validate
5. apply


# change management
procedure that will be followed when resources are modified (change)
change automation is creating a constient way of managing changings
terraform uses Execution Plans and Resources graphs

## plans
- manual review of changes that needs to be approved
- can be visualized using the terraform graph command and piping to GraphViz
- `terraform graph | dot -Tsvg > graph.svg`
- this graph shows the dependencies between resources and determines order of deployment, what to refresh, etc.




