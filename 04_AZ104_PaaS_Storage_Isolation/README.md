# 🔒 Project 4: Enterprise PaaS Storage Isolation & Private Link

## 📖 Live Implementation Architecture Chronicles

To track the strategic engineering choices, step-by-step private networking setups, and split-brain DNS validation logs behind this PaaS security isolation lab, review my live technical journal:
*   [Technical Journal: Enterprise PaaS Storage Isolation & Zero-Trust Perimeter Lockdown]https://dev.to/abhishek_kadlii_9ef4ca8bc/the-underground-tunnel-how-i-locked-down-enterprise-storage-without-breaking-the-app-2lcg


## 🗺️ Lab Objective
Demonstrate secure data-plane network isolation for multi-tenant Platform-as-a-Service (PaaS) resources within Microsoft Azure. This lab focuses on completely ripping up public internet entry paths to an Azure Storage Account, establishing a zero-trust network perimeter, and forcing all incoming data plane traffic through an internal Private Endpoint interface bound to an isolated Virtual Network subnet.

---

## 🛠️ Step-by-Step Command-Line Execution Blueprint

```bash
# 1. Establish the clean resource group container
az group create --name Marathahalli_Lab_RG --location southeastasia

# 2. Deploy the core management virtual network pipeline topology
az network vnet create \
  --resource-group Marathahalli_Lab_RG \
  --name Sec_Hub_SEA_VNet \
  --location southeastasia \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name Management_SEA_Subnet \
  --subnet-prefixes 10.0.1.0/24

# 3. Provision the multi-tenant baseline Storage Account asset
az storage account create -g Marathahalli_Lab_RG -n storevaultsea20949 -l southeastasia --sku Standard_LRS

# 4. Fire the Edge Kill-Switch: Revoke public internet access completely
az storage account update -g Marathahalli_Lab_RG -n storevaultsea20949 --public-network-access Disabled
```

---

## 🚙 Code Logic Decoder (In Plain, Simple Words)

* **`az network vnet create ... --address-prefixes 10.0.0.0/16`**
  This creates a massive private software-defined network space containing over 65,000 internal IP addresses. It carves out an isolated sandbox room (`Management_SEA_Subnet`) using the `10.0.1.0/24` range where our internal resources and private interface cables will live.
  
* **`az storage account create ... --sku Standard_LRS`**
  Orders Azure's physical data center racks to initialize a storage space named `storevaultsea20949` using Standard Locally Redundant Storage (LRS), which duplicates our files three times inside a single facility for safety.

* **`az storage account update ... --public-network-access Disabled`**
  This is the security kill-switch. By default, Azure leaves storage accounts open to the public internet via a public IP. This command slams that front door completely shut. Any packet coming from the public web will get dropped at the edge, making it completely invisible to internet hackers.

---

## 📓 Real-World Operational Troubleshooting Journal

### 🚨 The Challenge: Cloud Shell Cache & Token Desynchronization
* **The Error Encountered:** While executing commands mid-sprint, the containerized Azure Cloud Shell terminal locked up and threw a glaring error: `Subscription was not found` or failed to recognize active resource groups.
* **The Root Cause:** Containerized cloud shell terminals cache active authentication tokens. When shifting between active free-trial subscriptions or when sessions experience a brief latency timeout, the background OAuth sync drops, corrupting the local session memory profile.
* **The Fix & Bypassing Strategy:** Instead of calling support or waiting for the shell container to cycle, the deployment was instantly pivoted into the graphical **Azure Portal GUI**. The infrastructure deployment was successfully mapped out and built using visual wizards, completely bypassing the broken CLI terminal cache.

---

## 💡 Key Architectural Caveats & Things to Keep in Mind

* **The DNS Split-Brain Trap:** When public access is disabled, internal servers still look up your storage account using its standard public web address (`storevaultsea20949.blob.core.windows.net`). If you don't link an internal **Private DNS Zone** named exactly `privatelink.blob.core.windows.net`, your internal servers will keep asking the public internet for the IP, resulting in an immediate **403 Forbidden Error**.
* **Subnet Capacity Planning:** A Private Endpoint injects a virtual Network Interface Card (vNIC) straight into your subnet. This interface consumes a permanent private IP address out of your pool (in this lab, it grabbed `10.0.1.4`). When designing production networks, you must size your subnets to account for these private endpoint allocations so you don't run out of IPs.

---

## 🔎 Technical Verification Matrix
* **Edge Gate Security:** Public network access status explicitly verified inside the Networking portal panel as **`Disabled`**.
* **Private Cable Interface:** Private Network Interface Card successfully allocated internal private IP **`10.0.1.4`** within `Management_SEA_Subnet`.
* **DNS Map Resolution:** Active Recordsets table inside the Private DNS Zone verified as cleanly mapping the unique storage FQDN straight onto the internal private IP `10.0.1.4`.
