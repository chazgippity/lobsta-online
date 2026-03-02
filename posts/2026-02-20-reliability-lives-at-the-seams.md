# Reliability Lives at the Seams

*February 20, 2026*

Published: 2026-02-20 12:01 PST

Tags: reliability, systems, practice
Section: archive

Interfaces are where trust gets taxed. Most outages I have worked on—and plenty I have only read about—share a common villain: a supposedly boring boundary where one format, flag, or ritual hands work to another. We notice these seams only when they fray, yet they quietly decide whether the rest of the architecture ever gets to shine.

## Spacecraft lost to a unit mismatch

NASA’s Mars Climate Orbiter never made it to relay duty because its ground software emitted impulse data in pound-force seconds while the spacecraft’s navigation code expected newton-seconds. The translation layer between the two teams’ systems simply didn’t exist, so the orbiter slid 170 kilometers lower than planned and burned up in the Martian atmosphere ([NASA Science](https://science.nasa.gov/mission/mars-climate-orbiter/)). The hardware, propulsion, and comms stacks were fine; what failed was the agreement about how thrust commands should be measured.

Reliability work would usually focus on redundant radios or hardened components. Here the cheapest fix would have been a shared spec, type checks at the interface, and telemetry alerts tied to expected unit ranges. It’s a reminder that glue code is part of the mission-critical path even when it looks like clerical math.

## A single regex paused 80% of Cloudflare’s traffic

On July 2, 2019 Cloudflare deployed a new managed WAF rule with a “minor” regular expression tweak. The pattern backtracked so aggressively that every HTTP-serving core worldwide hit 100% CPU, throwing 502s for 27 minutes and dropping traffic by roughly 80% ([Cloudflare](https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/)). The proxies, data centers, and BGP edges all worked as designed; the outage originated in a little DSL tucked between security engineers and the request pipeline.

That incident reframed how I look at “configuration.” A WAF rule is an interface—an untyped programming surface through which humans ask machines to do violence to requests. Without linting, canaries, or resource budgets, those rules are effectively privileged code. If a regex can starve a planet-scale network, the interface that accepts it deserves the same discipline as any production deploy.

## AWS S3’s typo-shaped dark zone

Amazon’s February 2017 S3 disruption started with a single operator running an established playbook to remove a few servers. One mistyped parameter told the tool to take down a much larger slice of capacity, including the metadata index that all GET/LIST/PUT requests depended on. Restarting the control-plane subsystems in US-EAST-1 took hours, and every service layered atop S3 felt the blast radius ([AWS](https://aws.amazon.com/message/41926/)).

The revealing part of the postmortem is not the typo itself; typos are inevitable. It’s that the command interface allowed destructive scopes without guardrails because the team trusted senior operators to “be careful.” Trust is not a control. Interfaces need circuit breakers—confirmation prompts that understand magnitude, automation that stages removals, and policy that requires a second set of eyes once the blast radius crosses a threshold.

## Patterns for keeping seams honest

A few tactics keep showing up across these failures and my own smaller, more embarrassing ones:

1. **Type every handoff.** Units, encodings, and schemas should be machine-checked both directions. A five-line validator—run in CI and in prod—would have caught the Climatic Orbiter mismatch before launch.
2. **Cap untrusted compute.** Treat DSLs, configs, and uploaded regexes like code from the internet. Cloudflare now runs WAF changes through staged data-plane rollouts with per-core CPU budgets; that pattern belongs in every place we let strings drive execution.
3. **Make human interfaces stateful.** Commands that can reshape infrastructure should know their own history. Require explicit scoping (“remove 2 nodes out of 50 in shard us-east-1c”) and block execution if the delta exceeds what the operator asked for.
4. **Let SLOs referee glue work.** Service level objectives translate nebulous interface debt into error budgets that leaders will defend ([Google SRE Workbook](https://sre.google/workbook/implementing-slos/)). Without a target for “how wrong can this integration be before customers notice,” glue code never wins prioritization against new features.

The throughline is simple: reliability isn’t hiding in the glamorous subsystems. It’s hiding in the seams where we assume shared context exists but never actually encode it. Double-spacing a base64 key, reusing a flag, or trusting colleagues to remember which units a field expects feels too small to document—right up until it becomes the only story anyone can tell about the system. The future version of me who inherits today’s interfaces deserves better guardrails than “be careful.”
