# The Cloud Has a Physical Address
*March 3, 2026*
Published: 2026-03-03 08:15+00:00
Tags: infrastructure, war, iran, analysis
Section: analysis

On Sunday morning, Iranian drones struck three Amazon Web Services data centers. [Two facilities in the UAE took direct hits](https://www.cnbc.com/2026/03/02/amazon-says-drone-strikes-damaged-3-facilities-in-uae-and-bahrain.html); a third in Bahrain was damaged by a nearby strike. All three went offline.

AWS initially described the hits as "objects" that caused "sparks and fire." By Monday evening, they [acknowledged the cause](https://www.reuters.com/world/middle-east/amazon-cloud-unit-flags-issues-bahrain-uae-data-centers-amid-iran-strikes-2026-03-02/): drone strikes tied to the ongoing conflict. The damage includes structural failures, power disruption, and water damage from fire suppression. EC2, S3, and DynamoDB are all reporting elevated error rates. AWS says recovery will be "prolonged" and warns that Middle East operations are now "unpredictable."

## What Went Offline

This isn't just Amazon's problem. AWS's Middle East regions serve governments, banks, telecom providers, and thousands of businesses across the Gulf, South Asia, and East Africa. When those data centers go dark, the ripple isn't theoretical — it's payment systems failing, apps timing out, backups becoming unreachable.

AWS told customers to consider backing up data and potentially migrating workloads out of the region. That's a cloud provider telling its customers, mid-crisis, to *leave*.

## The Infrastructure Lesson

The cloud is a metaphor. Data centers are not. They are concrete buildings full of servers in specific postal codes, connected by physical fiber optic cables, cooled by physical HVAC systems, powered by physical electrical grids. They can be hit by the same drones that hit airports and embassies.

The tech industry spent two decades selling geographic redundancy as a solved problem. Put your data in multiple availability zones, replicate across regions, and your infrastructure becomes functionally immortal. That sales pitch assumed the failure modes were natural disasters and hardware failures — not coordinated military strikes across an entire region.

When Iran strikes UAE *and* Bahrain *and* Qatar simultaneously, the "multi-AZ" architecture that's supposed to provide resilience fails at its core assumption: that failures are independent and uncorrelated.

## The Concentration Problem

Here's what makes this worse: the Gulf has become a major hub for cloud infrastructure precisely because of its position between European and Asian markets, its cheap energy, and its governments' eagerness to attract tech investment. The same geographic centrality that makes it attractive for data routing makes it a target when the region becomes a war zone.

This isn't limited to AWS. Any hyperscaler with Gulf presence — Microsoft Azure, Google Cloud, Oracle — faces the same exposure. The physical infrastructure that runs the digital economy is sitting inside the blast radius of an active conflict.

## The Other Infrastructure Hit

In a related note: [three US F-15E Strike Eagles were shot down over Kuwait](https://www.cbsnews.com/news/us-f-15-jets-mistakenly-shot-down-kuwait-riendly-fire-crew-safe/) on Monday night — not by Iranian forces but by [Kuwaiti air defenses](https://www.theguardian.com/world/2026/mar/02/us-fighter-jets-kuwait) in an apparent friendly fire incident. All six crew ejected safely.

This tells the same story from a different angle: when the operational environment becomes chaotic enough, the systems designed to protect you start causing damage. Kuwait's air defenses, tuned to intercept Iranian drones and missiles, couldn't distinguish allied jets from threats. AWS's regional architecture, designed for resilience, couldn't withstand correlated strikes across multiple countries.

Complexity fails at the seams. It always does.

## What This Means

The immediate business impact is manageable — companies will migrate workloads, AWS will rebuild. But the strategic question is bigger: should critical digital infrastructure be located in regions that could become active war zones?

Until last Friday, the Gulf was a stable, well-connected, energy-rich hub for cloud expansion. Now it's a place where data centers get hit by drones. That reputational shift will outlast the conflict. Expect accelerated investment in European, Southeast Asian, and North African data center capacity — not because those regions are safer in absolute terms, but because the Gulf just demonstrated that "low probability, high impact" risks are sometimes just high-impact risks waiting for their moment.

---

*The cloud isn't above the weather. It never was.*
