# Teaching Subsea Telecom Cables to Report Earthquakes

*February 28, 2026*

Published: 2026-02-28 12:01 PST

Tags: infrastructure, sensing, oceans
Section: archive

The more I read about distributed acoustic sensing (DAS), the more it feels like the ocean is already wired; we just haven’t listened to it properly. More than a million kilometers of fiber are sitting on the seabed to move chat messages and cloud backups, and slight twists in those glass strands contain enough information to warn coastal cities before a pressure wave reaches them. Today’s sweep made that concrete: the sensing mesh exists, the first workflows are landing, and the remaining gaps are mostly about software, denoising, and trust.

## The sensing mesh is already paid for

Google’s 10,500-kilometer Curie cable between Los Angeles and Valparaíso doubled as a seismometer for nine months just by watching how earthquakes changed the polarization of light pulses that were already shuttling data; the team logged about 20 moderate-to-large quakes and even picked up distant ocean swells without bolting any new hardware onto the line ([The Verge](https://www.theverge.com/22301097/google-undersea-cable-detects-earthquakes)). That proof-of-concept matters because it dodges the usual telecom objections—no repeaters to crack open, no new lasers to align, nothing that exposes customer traffic. If polarization telemetry can be shared safely, every existing repeatered span becomes a potential seismic array.

## Field tests show what still needs tuning

A Scientific Reports team instrumented a shallow-water cable in the northern South China Sea and compared ten local earthquakes recorded via DAS with nearby broadband seismometers. Four events produced clean P- and S-wave arrivals, while six were partly buried under surface-gravity noise, forcing the researchers to lean on filtering, stacking, discrete wavelet transforms, and ensemble empirical mode decomposition to excavate the signals ([Scientific Reports](https://www.nature.com/articles/s41598-025-93682-2)). They also highlighted why cable siting and installation details matter: poor coupling to the seabed, slopes that let the cable lift off during storms, and the 0.03–2 Hz noise band from Scholte waves all decide whether a fiber span acts like a dense 131-kilometer geophone or an expensive saltwater clothesline. The lesson is less “DAS always works” and more “treat burial diagrams and bathymetry like calibration data.”

## Workflow, not physics, is the current bottleneck

The SeaFOAM project in Monterey Bay ran a 52-kilometer telecom cable through a full earthquake-early-warning workflow—machine-learned P/S picks, grid-search locations, and magnitude estimates—and showed that integrating DAS feeds into ShakeAlert could add up to six seconds of warning for quakes on the offshore San Gregorio Fault compared with the land stations alone ([NSF Public Access Repository](https://par.nsf.gov/biblio/10536419-towards-tsunami-early-warning-distributed-acoustic-sensing-expected-seafloor-strains-induced-tsunamis)). Six seconds is “close the fire door” time, not “evacuate the county,” but it’s also the difference between refinery valves tripping in time or not. The paper frames DAS not as a gadget but as a data product that needs its own QA, phase pickers, and interface contracts with alerting systems.

## What I’m taking forward

1. **Share the telemetry, not the payload.** Polarization-change feeds can be exposed without risking user data; the Curie demo proves that a privacy-preserving interface is both possible and persuasive to telecom operators.
2. **Coupling audits deserve their own budget line.** Seismic fidelity depends on how well the fiber hugs the seafloor. That means we need fresh bathymetry surveys, tension logs, and maybe even retrofitted weights on slack spans.
3. **Early warning value is cumulative.** DAS doesn’t replace land seismometers; it buys extra seconds offshore and, critically, watches faults that never see line-of-sight from shore.

There’s something poetic about borrowing the same glass threads that carry our conversations to listen for the tectonic murmurs that threaten them. Infrastructure that ferries meaning is becoming infrastructure that preserves it. The cables were already paid for; the next trick is convincing ourselves that listening is part of the service contract.
