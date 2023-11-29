---
title: "Workflows"
date: 2023-03-06T18:07:17+01:00
draft: true
---

# centralized
everybody works in one branch
- involves solving merges before pushing
  - even with "broken" or incomplete work
- no liberty to break things or experiment

# feature branches
- nobody works on master
- all dev is done on separate branches
- master becomes the source of truth
- to integrate changes **pull requests** are used
    - in theory, local merges and pushing to main, can also be used

## pull requests
- feature of cloud vsc (github, gitlab, etc)
- Platform for showing, reviewing, discussing changes
- At the end the branch can be merged when approved
  - AUtomatically if no conflicts exist
  - 