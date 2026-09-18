# 📊 Project 7: Enterprise Observability & Log Analytics Diagnostics

## 🗺️ Lab Objective
Design, provision, and deploy a centralized enterprise log collection and system metrics perimeter. This project sets up an isolated data plane architecture using an Azure Log Analytics Workspace, wires live Linux compute assets via the Azure Monitor Linux Agent (AMA) extension, and leverages custom Kusto Query Language (KQL) parsing scripts to dynamically identify critical hardware strains and audit security authentication compromises.

---

## 🏢 Finding the Needle in the Cloud Haystack: Real-Time Diagnostics with KQL

When an application drops requests or degrades across distributed availability zone networks, logging into individual virtual machine nodes via SSH tools one by one to manually filter out logs wastes critical service recovery time. In this infrastructure track, I aggregated raw diagnostic metrics into a central collection workspace, allowing automated query parsing and modern telemetry observability.

### 🏰 The Analogy: The Building CCTV Control Room
*   **Manual Incident Diagnostics (The Flashlight Search):** Walking through a massive 50-story corporate corporate building, manually opening every single individual storage room and office door with a flashlight to search for a single failed lightbulb.
*   **Centralized Observability (The System Video Wall):** Sitting inside an automated facility security control room where a unified central video display immediately flags the exact malfunctioning office room, graphs the real-time electrical voltage drop value, and routes an automated incident ticket straight to the on-call engineer's phone.

```text
[ Central India VM Node 1 ] ──┐
[ Core Compute Engine VM  ] ──┼──► [ Log Analytics Workspace ] ──► (KQL Parsing Engine) ──► [ Incident Notice ]
[ Infrastructure Node 3   ] ──┘
```

---

## 🛠️ Step-by-Step Command-Line Execution Blueprint

### 1. Provisioning the Cloud Monitoring Sandbox Perimeter
```bash
# 1. Initialize the dedicated monitoring container group inside Central India region
az group create --name "Marathahalli_Monitoring_India_RG" --location "centralindia"

# 2. Deploy the high-capacity central Log Analytics Workspace cluster
az monitor log-analytics workspace create \
  --resource-group "Marathahalli_Monitoring_India_RG" \
  --workspace-name "CentralOpsWorkspaceIndia" \
  --location "centralindia"
```

### 2. Attaching Fleet Compute Assets via Azure Monitor Agent (AMA)
```bash
# 3. Spin up an approved Standard_B2ats_v2 host inside the local group boundary
az vm create \
  --resource-group "Marathahalli_Monitoring_India_RG" \
  --name "Hub-Mgmt-VM" \
  --image "Ubuntu2204" \
  --size "Standard_B2ats_v2" \
  --location "centralindia" \
  --admin-username "abhishek" \
  --generate-ssh-keys

# 4. Bind the operational Linux collection agent extension to stream metrics
az vm extension set \
  --resource-group "Marathahalli_Monitoring_India_RG" \
  --vm-name "Hub-Mgmt-VM" \
  --name "AzureMonitorLinuxAgent" \
  --publisher "Microsoft.Azure.Monitor"
```

---

### ⚙️ Production Kusto Query Language (KQL) Diagnostic Matrix

#### 🔍 Metric Query 1: Surfacing Host CPU Processor Strain (> 80%)
Continuously monitors raw performance tables (`Perf`), isolates processor metrics, groups historical data records into clean 5-minute aggregation buckets (`bin`), and identifies the highest hardware strains to surface system degradations:

```kql
Perf
| where ObjectName == "Processor" and CounterName == "% Processor Time"
| where CounterValue > 80
| summarize AvgCPU = avg(CounterValue) by Computer, bin(TimeGenerated, 5m)
| order by TimeGenerated desc
```

#### 🔍 Metric Query 2: Auditing Malicious Host Authentication Attacks
Continuously parses incoming core server activity logs (`Syslog`) specifically for authentication facilities (`auth`) that match failed password attempts. It targets strings, using regular expressions to extract hostile attacker IP strings into a separate clean field for firewall blacklisting:

```kql
Syslog
| where Facility == "auth" and SyslogMessage contains "Failed password"
| summarize FailedAttempts = count() by HostName, SourceIP = extract(@"\d+\.\d+\.\d+\.\d+", 0, SyslogMessage)
| order by FailedAttempts desc
```

---

## 🚙 Code Logic Decoder (In Plain, Simple Words)

*   **`summarize AvgCPU = avg(CounterValue) by Computer, bin(TimeGenerated, 5m)`**
    Instead of outputting thousands of confusing, duplicate data metric lines every single second, this command bundles the raw information timeline into tight 5-minute buckets (`bin`). It averages out performance calculations per instance name, giving engineers clean operational visibility.
*   **`SourceIP = extract(@"\d+\.\d+\.\d+\.\d+", 0, SyslogMessage)`**
    This applies a regular expression (regex) wildcard tracking logic string. It scans unformatted host system error logs, intercepts strings matching four number components separated by periods, and pulls the attacker's IP string into an individual table display column for immediate tracking.

---

## 📓 Real-World Enterprise Operational Troubleshooting Journal

### 🚨 1. Subscription Governance Interception Block (`Code: RequestDisallowedByPolicy`)
*   **The Challenge:** Initial attempts to stand up the log generator host (`az vm create`) crashed with a fatal pre-flight API block indicating policy constraints were breached.
*   **The Root Cause:** Prior architectural tracks implemented a broad subscription-wide policy restricting VM shapes to low-cost configurations (`Standard_B2s` or `Standard_B2ats_v2`). Attempting a standard `Standard_B1s` test deployment breached this rule, triggering an immediate gate block.
*   **The Fix:** Changed the CLI hardware argument explicitly to an approved whitelisted shape (`--size Standard_B2s`), matching global tenant governance rules.

### 🚨 2. Cross-Region Datacenter Capacity Exhaustion (`Code: SkuNotAvailable`)
*   **The Challenge:** The adjusted VM build failed a second time inside the Singapore (`southeastasia`) datacenter, throwing an active capacity restriction error.
*   **The Root Cause:** High computing resource usage across Southeast Asia fully exhausted the physical datacenter hardware frames for both whitelisted B-series shapes simultaneously.
*   **The Fix:** Migrated the deployment target room entirely to the Central India region (`centralindia`), accessing open computing clusters while remaining inside subscription policy bounds.
