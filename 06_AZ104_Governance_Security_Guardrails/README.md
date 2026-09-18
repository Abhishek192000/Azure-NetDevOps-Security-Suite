# 🛡️ Project 6: Governance & Security Guardrails

## 🗺️ Lab Objective
Establish automated control plane guardrails within an enterprise subscription framework. This project engineers a custom Azure Policy definition applied at the resource group scope to automatically deny non-authorized virtual machine sizes, alongside a custom least-privilege RBAC role to restrict operator identities exclusively to virtual machine reboot activities.

---

## 🏢 Stopping Rogue Deployments: How I Programmed Azure API Guardrails to Protect the Cloud Wallet

In large-scale enterprise IT environments, massive cloud bills rarely happen because of malice; they happen because of human error. A junior engineer tries to test a basic shell script, accidentally selects a high-end enterprise or GPU virtual machine size costing thousands of rupees an hour, and forgets to deprovision it over the weekend. 

Instead of sending angry corporate emails asking teams to be careful, I stepped up as a DevSecOps engineer and programmed the **Azure Resource Manager (ARM) API gateway** itself to decline unauthorized resources automatically using **Azure Policy** and **Custom RBAC Least-Privilege roles**.

---

### 🏰 The Analogy: The Bouncing Corporate Credit Card

* **The Weak Setup:** Relying on human memory, training documentation, or sticky notes. People get tired, mistakes happen, and cloud credits get wasted instantly.
* **The Guardrail Setup:** Programming the card terminal directly at the cash register. If an employee tries to buy an unapproved item or make a purchase outside allowed parameters, the transaction gets declined instantly at the terminal. 

```text
                               ┌──► [ Approved Shape: B-Series Only ] ──► ✅ ALLOWED (Passes Gate)
                               │
[ Deployment Request ] ──► [ Azure Policy ARM Gate ]
                               │
                               └──► [ Prohibited Shape: D-Series Node ] ──► ❌ DENIED (Declined at Register)
```

---

### 🛠️ The Step-by-Step Command-Line Execution Blueprint

To ensure absolute governance control, I deployed the complete policy enforcement framework directly inside the **Southeast Asia** datacenter region using the Azure CLI:

#### 1. Writing the JSON Policy Definition (`allowed-skus.json`)
First, I defined a strict policy framework file that restricts virtual machine sizes exclusively to cost-effective B-series types, setting the active enforcement flag to a forceful `deny`:

```json
{
  "if": {
    "allOf": [
      { 
        "field": "type", 
        "equals": "Microsoft.Compute/virtualMachines" 
      },
      { 
        "field": "Microsoft.Compute/virtualMachines/sku.name", 
        "notIn": ["Standard_B1s", "Standard_B2ats_v2"] 
      }
    ]
  },
  "then": { 
    "effect": "deny" 
  }
}
```

#### 2. Enforcing the Policy at Resource Group Scope
Next, I registered the custom rule with the subscription engine and bound the assignment scope strictly to our target lab container room:

```bash
# Initialize the target resource perimeter container
az group create --name Marathahalli_Lab_RG --location southeastasia

# Register the core custom Azure Policy definition rule container
az policy definition create \
  --name restrict-vm-skus \
  --rules allowed-skus.json \
  --display-name "Restrict VM SKUs to B-Series"

# Assign the policy enforcer live to the Resource Group scope
az policy assignment create \
  --name "Enforce_B_Series_Only" \
  --policy restrict-vm-skus \
  --resource-group Marathahalli_Lab_RG
```

---

### ⚙️ Creating a Custom Least-Privilege RBAC Role

To lock down human identities, I designed a tailored JSON file (`vm-operator-role.json`) defining a custom Role-Based Access Control (RBAC) profile for junior operators. This grants granular rights to read and restart virtual machines, while completely blocking structural modifications or resource deletions:

```json
{
  "Name": "VM Restart Operator",
  "IsCustom": true,
  "Description": "Can only restart VMs.",
  "Actions": [
    "Microsoft.Compute/virtualMachines/read",
    "Microsoft.Compute/virtualMachines/restart/action"
  ],
  "NotActions": [],
  "AssignableScopes": ["/subscriptions/YOUR_SUBSCRIPTION_ID"]
}
```

I dynamically claimed the active subscription ID using the CLI and registered the least-privilege role directly with the Azure identity control plane API:

```bash
# Dynamically inject current subscription context and register role
SUB_ID=$(az account show --query id --output tsv)
sed -i "s|YOUR_SUBSCRIPTION_ID|$SUB_ID|g" vm-operator-role.json

az role definition create --role-definition vm-operator-role.json
```

---

### 📓 The TAC Engineer's Troubleshooting Journal

#### 🚨 Challenge: The Cascading API Error Mismatch (`Code: ResourceGroupNotFound`)
* **The Problem:** During deployment, the policy assignment utility crashed instantly, spitting out a glaring red terminal error: *Resource group 'Marathahalli_Lab_RG' could not be found.*
* **The Root Cause:** To prevent ongoing background costs, our sandboxes are systematically torn down after validation sprints. Running an assignment scope mapping against a non-existent container crashes the ARM API engine.
* **The Resolution:** I refactored the playbook sequence to pre-pend a clean resource group initialization command (`az group create`), establishing the network room container before binding the policy structures to it.

---

### 🚀 Live Workload Validation: The RequestDisallowedByPolicy Block

To verify the strength of the guardrails, I simulated an accidental deployment breach by attempting to provision a large, unapproved enterprise-tier computing instance (`Standard_D4s_v3`) inside the protected resource group:

```bash
az vm create \
  --resource-group Marathahalli_Lab_RG \
  --name Rogue_VM \
  --image Ubuntu2204 \
  --size Standard_D4s_v3 \
  --admin-username abhishek \
  --generate-ssh-keys
```

#### 📸 Proof Point: The Gate Defends the Wallet
The command spun for a few seconds, hit the ARM API gate, and was instantly blocked! The deployment failed completely, preventing a single rupee from being billed:

```text
azure.core.exceptions.HttpResponseError: (InvalidTemplateDeployment) The template deployment failed because of policy violation. 
Code: InvalidTemplateDeployment
Message: The template deployment failed because of policy violation. Please see details for more information.
Exception Details: (RequestDisallowedByPolicy) Resource 'Rogue_VM' was disallowed by policy 'Enforce_B_Series_Only'.
```

---

### 💡 Core AZ-104 Exam Lessons Learned

* **Policy Effect Alternatives:** While `deny` stops resources immediately at the gate, using `audit` allows deployments to pass through but flags them inside a compliance dashboard—ideal for mapping existing production assets without breaking application uptime.
* **Granular Custom Actions:** Custom RBAC configurations require structural precision. Combining explicit wildcard elements (`*`) under `Actions` with exclusion flags under `NotActions` lets you craft bulletproof security boundaries tailored to specific job profiles.
