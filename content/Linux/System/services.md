---
title: "Service Management"
date: 2025-08-12T14:57:21+02:00
draft: false
---

`systemd` is the default init system and service manager in many modern Linux distributions. It is responsible for:

* Initializing the system at boot.
* Managing system and user services.
* Handling system states and targets (boot modes) See [System startup]({{< ref "linux/system/system-startup" >}}).
* Logging via the system journal.

Unlike traditional init systems, `systemd` starts services in **parallel**, which can speed up boot times. It manages **units**, which are objects that describe system resources and how they should be handled.

## Unit Types

A **unit** is a configuration object that represents something `systemd` can manage.
Common unit types include:

* **Service units (`.service`)** – background processes such as daemons or applications.
* **Target units (`.target`)** – groupings of units representing a system state (e.g., `graphical.target`, `multi-user.target`).
* **Socket units (`.socket`)** – network or IPC sockets that can trigger services on demand.
* **Device units (`.device`)** – represent hardware devices recognized by the kernel.
* **Mount and automount units (`.mount`, `.automount`)** – define and manage filesystem mounts.
* **Timer units (`.timer`)** – scheduled tasks, similar to `cron`, but managed by `systemd`.

## Unit Files and Directories

Unit definitions are stored in configuration files with a `.unit` extension (e.g., `.service`, `.target`).

`systemd` loads unit files from multiple directories in order of precedence:

1. `/etc/systemd/system/` – local administrator-defined units (highest priority).
2. `/run/systemd/system/` – runtime-generated units (cleared on reboot).
3. `/lib/systemd/system/` or `/usr/lib/systemd/system/` – distribution-provided units (lowest priority).

Unit files are INI-style and generally have these sections:

```ini
[Unit]
Description=Description of the service
Documentation=URL or path to docs
After=other.service
Requires=dependency.service

[Service]
ExecStart=/path/to/command
User=username
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

---

## How `systemd` Starts and Manages Services

1. **Boot process** – The kernel starts `systemd` as the first user-space process (`PID 1`).
2. **Default target** – `systemd` determines the default boot state (e.g., `graphical.target`).
3. **Dependency resolution** – Units required by the target are started, respecting dependencies defined in `Requires=`, `Wants=`, and `After=`.
4. **Parallel execution** – Independent units are started simultaneously.
5. **Ongoing management** – Services are monitored and can be restarted automatically if they fail (`Restart=` option).



## Managing Services with `systemctl`

`systemctl` is the primary command-line tool for interacting with `systemd`.

**Service control**

```bash
systemctl start <service>     # Start a service
systemctl stop <service>      # Stop a running service
systemctl restart <service>   # Restart a service
systemctl reload <service>    # Reload service configuration
```

**Enable/disable on boot**

```bash
systemctl enable <service>    # Start at boot
systemctl disable <service>   # Do not start at boot
```

**Status and inspection**

```bash
systemctl status <service>    # View service status and recent logs
systemctl list-units          # List active units
systemctl list-unit-files     # List all available units and enablement state
```

**Reloading definitions**

```bash
systemctl daemon-reload       # Reload unit files after editing
```



## Logging with `journalctl`

`systemd` uses the journal to store logs for the entire system. Logs can be queried with `journalctl`.

Common options:

```bash
journalctl -b           # Logs from current boot
journalctl -u <unit>    # Logs for a specific service
journalctl --since "1 hour ago" # Filter by time
```
