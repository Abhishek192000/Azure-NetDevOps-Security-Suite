# 🏢 Azure NetDevOps & Cloud Security Architecture Suite

Welcome to my enterprise cloud security and automation portfolio. This repository serves as a centralized production-grade framework demonstrating Layer-3 networking topologies, security perimeter controls, and automated DevSecOps validation pipelines in Azure.

---

## 📖 Live Implementation Documentation & Technical Write-ups

Explore the full end-to-end design choices, step-by-step technical narratives, and operational engineering logs on DEV.to:

*   [Technical Journal: Metric-Driven Scaling and Managing Global SKU Crushes in VMSS Clusters]https://dev.to/abhishek_kadlii_9ef4ca8bc/-the-self-healing-server-fleet-how-i-mastered-automation-beat-global-sku-crushes-and-solved-5d8
*   [Technical Journal: Enterprise PaaS Storage Isolation & Zero-Trust Perimeter Lockdown]https://dev.to/abhishek_kadlii_9ef4ca8bc/the-underground-tunnel-how-i-locked-down-enterprise-storage-without-breaking-the-app-2lcg
*   [Day 9 & 10: Shifting to IaC — Writing the 183-Line Central NVA Firewall Engine in Bicep]https://dev.to/abhishek_kadlii_9ef4ca8bc/shifting-to-iac-writing-the-183-line-central-firewall-engine-in-bicep-when-the-portal-hits-a-wall-1n5l
*   [Day 8: The Live Traffic Intercept — Bringing the Cloud Fortress to Life]https://dev.to/abhishek_kadlii_9ef4ca8bc/the-live-traffic-intercept-bringing-the-cloud-fortress-to-life-day-8-323l
*   [Day 6 & 7: Sunday Double Header — Erecting Checkpoints & Traffic Hijacking in the Cloud]https://dev.to/abhishek_kadlii_9ef4ca8bc/sunday-double-header-erecting-checkpoints-and-traffic-hijacking-in-the-cloud-day-6-7-388h
*   [Day 4 & 5: Weekend Grind — Breaking the GUI Habit & Building a Scalable Cloud Fortress]https://dev.to/abhishek_kadlii_9ef4ca8bc/weekend-grind-breaking-the-gui-habit-and-building-a-scalable-cloud-fortress-in-azure-day-4-5-241o
*   [Day 1: My First Day in the Cloud — How I Built a Secured Digital Fortress in Azure]https://dev.to/abhishek_kadlii_9ef4ca8bc/my-first-day-in-the-cloud-how-i-built-a-secured-digital-fortress-in-azure-3aka

---

## 🗺️ Master Portfolio Suite Index

```text
Azure-NetDevOps-Security-Suite (Master Hub Repository)
 │
 ├── 📁 01_Enterprise_Secure_Landing_Zone ──► [Project 1: Secure Hub-and-Spoke Topology]
 │                                              └── Core L3 routing hijack via UDR perimeters.
 │
 ├── 📁 02_Automated_SecOps_Pipelines      ──► [Project 2: Automated SecOps CI/CD Pipeline]
 │                                              └── Syntax conformance & dry-run validation gates.
 │
 ├── 📁 03_PaloAlto_NVA_Cloud_Perimeter    ──► [Project 3: Palo Alto VM-Series NVA Integration]
 │                                              └── Virtual Firewall appliance transit integrations.
 │
 ├── 📁 04_AZ104_PaaS_Storage_Isolation   ──► [Project 4: Enterprise PaaS Storage Isolation]
 │                                              └── Data-plane edge lock down & Private Link tunnels.
 │
 └── 📁 05_AZ104_HighAvailability_VMSS     ──► [Project 5: Metric-Driven Self-Healing VMSS Fleet]
                                                └── Automatic horizontal scale nodes behind LB layer.
```

---

## 🛠️ Deep-Dive Project Breakdowns

Click directly into any project folder above to view its dedicated documentation, architecture diagrams, real-world analogies, and file explanations.

### 📌 Project 1: Enterprise Secure Hub-and-Spoke Landing Zone
*   **Location**: `📁 01_Enterprise_Secure_Landing_Zone`
*   **Focus**: Layer-3 cloud networking architecture, Azure Firewall Premium routing perimeters, custom User Defined Routes (`0.0.0.0/0`), and symmetric VNet Peering transit paths.

### 📌 Project 2: NetDevOps Automated Validation Pipeline
*   **Location**: `📁 02_Automated_SecOps_Pipelines`
*   **Focus**: Continuous Integration (CI) workflows via GitHub Actions cloud runners, canonical layout conformance testing (`terraform fmt`), and dry-run infrastructure validations (`terraform validate`).

### 📌 Project 3: Palo Alto VM-Series NVA Transit Integration
*   **Location**: `📁 03_PaloAlto_NVA_Cloud_Perimeter`
*   **Focus**: Network Virtual Appliance (NVA) core structures, multi-interface routing isolation (Management, Trust, Untrust segments), overriding Azure transit blocks (`enable_ip_forwarding = true`), and commercial vendor Marketplace billing plan authorizations (`plan`).

### 📌 Project 4: Enterprise PaaS Storage Isolation & Private Link
*   **Location**: `📁 04_AZ104_PaaS_Storage_Isolation`
*   **Focus**: PaaS data-plane network perimeter lock down, revoking public network visibility status, allocating internal Private Endpoints (`10.0.1.4`), and mapping internal split-brain routing zones via custom Private DNS.

### 📌 Project 5: Metric-Driven High-Availability Server Fleet (VMSS)
*   **Location**: `📁 05_AZ104_HighAvailability_VMSS`
*   **Focus**: Horizontal compute scaling via Uniform Orchestration fleets, Layer 4 Azure Load Balancer backend distributions, metric aggregate monitoring policies, and programmatic `stress` testing configurations.
