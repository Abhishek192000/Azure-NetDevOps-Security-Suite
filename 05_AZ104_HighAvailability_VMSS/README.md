# 🚀 Project 5: Metric-Driven High-Availability Server Fleet (VMSS)

## 🗺️ Lab Objective
Configure a self-healing, horizontally autoscaling web server farm using an Azure Virtual Machine Scale Set (VMSS) running under Uniform Orchestration Mode. The infrastructure utilizes metric monitoring sensor profiles to automatically detect sudden resource utilization breaches and dynamically deploy identical compute instances behind a Layer 4 Load Balancer without human intervention.

---

## 🛠️ Automated Deployment Playbook (Azure CLI)

```bash
# Define isolated V2 environment parameters
RG_V2="Marathahalli_Lab_RG_V2"
REGION="centralindia"

# 1. Stand up an unblocked, clean resource container
az group create --name $RG_V2 --location $REGION

# 2. Build the production application networking subnets
az network vnet create \
  --resource-group $RG_V2 \
  --name Sec_Hub_SEA_VNet \
  --location $REGION \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name Prod_App_Subnet \
  --subnet-prefixes 10.0.2.0/24

# 3. Provision the Uniform Orchestration Compute scale fleet behind an Azure Load Balancer
az vmss create \
  --resource-group $RG_V2 \
  --name WebAppVMSS \
  --location $REGION \
  --image Ubuntu2204 \
  --vm-sku Standard_D2s_v5 \
  --instance-count 1 \
  --vnet-name Sec_Hub_SEA_VNet \
  --subnet Prod_App_Subnet \
  --lb WebAppLB \
  --backend-pool-name WebAppBackendPool \
  --orchestration-mode Uniform \
  --admin-username abhishek \
  --generate-ssh-keys

# 4. Bind the Autoscale Metric Monitoring profile container
az monitor autoscale create \
  --resource-group $RG_V2 \
  --resource WebAppVMSS \
  --resource-type Microsoft.Compute/virtualMachineScaleSets \
  --name CPU_Autoscale_Policy \
  --min-count 1 \
  --max-count 3 \
  --count 1

# 5. Inject the scale-out trigger rule (Add 1 node if CPU capacity spikes > 70% for 3 minutes)
az monitor autoscale rule create \
  --resource-group $RG_V2 \
  --autoscale-name CPU_Autoscale_Policy \
  --scale out 1 \
  --condition "Percentage CPU > 70 avg 3m"
```

---

## 🚙 Code Logic Decoder (In Plain, Simple Words)

* **`az vmss create ... --orchestration-mode Uniform`**
  This forces the Scale Set to ensure that every single virtual machine instance it spins up is an exact, identical carbon copy of our baseline Ubuntu Linux template. This is the enterprise standard for building stateless, scalable web application farms.
  
* **`az vmss create ... --lb WebAppLB --backend-pool-name WebAppBackendPool`**
  This tells Azure to deploy a network traffic manager (Layer 4 Load Balancer) in front of our servers. When traffic hits the public front gate, the load balancer evenly splits the data packets and distributes them across the background server instances, protecting individual nodes from getting overwhelmed.

* **`az monitor autoscale rule create ... --condition "Percentage CPU > 70 avg 3m"`**
  This acts as an automated cloud sensor. It monitors our servers 24/7. If the average CPU load across our fleet crosses 70% and stays there for 3 consecutive minutes, it triggers the scale-out action, automatically ordering the data center to spin up another server node.

---

## 📓 The Production Troubleshooting Journal: 3 Major Challenges Solved

### 🚨 1. Global Datacenter Capacity Constraints (`Code: SkuNotAvailable`)
* **The Challenge encountered:** The deployment script originally targeted free-tier baseline sizes (`Standard_B2s`), resulting in an immediate preflight validation crash across multiple regions. The message read: *The requested VM size... is currently not available due to capacity restrictions.*
* **The Root Cause:** Free-trial subscription tiers share a restricted, low-priority pool of physical hardware blocks inside Azure's data centers. During peak hours, these baseline pools run completely dry, causing Azure to block new deployments.
* **The Fix:** Refactored the script infrastructure configurations to target **`Standard_D2s_v5`**—a mainstream enterprise-grade tier shape. Azure maintains massive hardware availability pools for this size, which completely bypassed the regional quota blockade and allowed the servers to provision instantly.

### 🚨 2. Linux OS Hostname Syntax Validation Fault (`Code: InvalidHostNamePrefix`)
* **The Challenge encountered:** The compute allocation script threw a traceback error indicating the host name prefix was completely invalid according to systemic preflight validation rules.
* **The Root Cause:** The initial scale set resource name contained an underscore character (`WebApp_VMSS`). Under the hood, Azure uses the scale set name to automatically stamp out machine hostnames for every individual instance. However, Linux operating systems strictly forbid underscore characters (`_`) inside system hostnames.
* **The Fix:** Refactored the architecture naming conventions to use clean **CamelCase** formatting (`WebAppVMSS`), passing validation seamlessly.

### 🚨 3. Deprovisioning Cloud Racing Conditions (`Code: ResourceGroupBeingDeleted`)
* **The Challenge encountered:** Re-running deployment scripts threw an error stating that the resource container was locked in a deprovisioning state and could not perform the operation.
* **The Root Cause:** Re-running labs too fast after a teardown causes a racing condition. Because the `--no-wait` flag was used, the previous deletion command was still executing in the background, locking the resource group name while it cleared out old routing paths.
* **The Fix:** Bypassed the active background locks completely by appending a version control suffix (**`_V2`**) to our resource group naming parameters, creating a brand new isolated workspace instantly without sitting around waiting for background processes to finish.

---

## 💡 Key Architectural Caveats & Things to Keep in Mind

* **Autoscale Flapping Conditions:** When configuring autoscale out rules, you must always remember to create corresponding **Scale In rules**. If you don't, your server farm will grow when traffic spikes but will never shrink when the crowd leaves, draining your budget. Additionally, tuning the cooldown period is vital to prevent "flapping"—where nodes continuously scale up and down rapidly due to highly volatile traffic ripples.
* **Load Balancer Firewall Blocks:** A standard Azure Layer 4 Load Balancer blocks direct inbound SSH connections on Port 22 by default unless custom inbound NAT rules are mapped. To bypass this during testing, we used Azure's native global **Run Command infrastructure** to trigger our synthetic traffic spikes safely from inside the portal backbone.

---

## 🔎 Live Automation Validation Metrics
Workload resilience was validated using the global `run-command` module to stress instance 0:
```bash
az vmss run-command invoke \
  --resource-group Marathahalli_Lab_RG_V2 \
  --name WebAppVMSS \
  --instance-id 0 \
  --command-id RunShellScript \
  --scripts "sudo apt-get update && sudo apt-get install stress -y && stress --cpu 4 --timeout 240"
```
**Verification Victory:** The monitoring sensors registered the sustained 100% processing load breach, evaluated the time aggregation window, and automatically provisioned **`WebAppVMSS_1`** within 3 minutes to handle the load completely on its own.
