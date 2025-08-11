---
title: "Scheduled Jobs"
date: 2025-08-11T16:40:04+02:00
draft: false
---


Scheduling jobs on Linux enables automatic execution of commands or scripts at specified times or intervals, facilitating system maintenance, backups, and other repetitive tasks without manual intervention.

## Cron — Recurring Scheduled Tasks

**Cron** is the most commonly used tool for scheduling recurring jobs. Each user has an individual crontab (cron table) file defining their scheduled tasks.

The crontab file uses a specific syntax consisting of five fields that specify the timing:

```
*    *    *    *    *
|    |    |    |    |
|    |    |    |    +----- Day of week (0-7, Sunday=0 or 7)
|    |    |    +---------- Month (1-12)
|    |    +--------------- Day of month (1-31)
|    +-------------------- Hour (0-23)
+------------------------- Minute (0-59)
```

Special notations include:

* `*` to indicate “any value”
* `*/n` to specify “every n units”

Examples of cron expressions:

* Every 5 minutes: `*/5 * * * *`
* At 3:30 AM daily: `30 3 * * *`

Crontab files are typically edited with the command:

```bash
crontab -e
```

Scheduled jobs can be listed with:

```bash
crontab -l
```

{{% notice style="info" title="System wide jobs" %}}
The command `crontab -l` displays the current user’s personal scheduled jobs stored in their individual crontab file. In contrast, system-wide scheduled tasks are defined in files like `/etc/crontab` and within the `/etc/cron.d/` directory, which allow administrators to configure jobs that apply to multiple users or the entire system. These system files include an additional field to specify the user under which each job runs.
{{% /notice %}}

## At — One-Time Scheduled Tasks

The **at** command schedules commands to be run once at a specified future time. Unlike cron, which manages recurring jobs, **at** is suitable for one-off tasks.

For example, to schedule a job at 6:00 PM today:

```bash
echo "sh /path/to/script.sh" | at 18:00
```

The system’s **atd** daemon must be running to process these jobs.

## Anacron — Handling Jobs on Systems Not Running Continuously

On systems that are not powered on 24/7 (like laptops), **anacron** ensures scheduled jobs still run even if the system was off at the scheduled time.

Anacron runs jobs defined in `/etc/anacrontab`, executing missed jobs once the system becomes active again.

This complements cron by providing better guarantees of job execution on intermittent systems.

