---
title: "Logs"
date: 2023-11-10T18:24:32+01:00
draft: false
---

Terraform can log to a file or to the standard output. The log level can be set to `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR`.

Logging is controlled by the `TF_LOG` environment variable. Different log levels can be set for different components by setting the `TF_LOG_[COMPONENT]` environment variable. For example, `TF_LOG_PROVIDER` sets the log level for providers and `TF_LOG_CORE` sets the log level for the core.

The `TF_LOG_PATH` environment variable can be used to set the path to the log file. If it is not set, the log is written to the standard output.