# 🤖 Project 2: NetDevOps Automated SecOps Validation Pipeline

An enterprise-grade, cloud-native Continuous Integration (CI) pipeline engineered utilizing **GitHub Actions**. This automation acts as an immutable static quality gate, programmatically parsing and validation framework blueprints on every trunk-based code delivery event before runtime execution.

---

## 🛡️ The Digital Airport Security Gate (The Real-World Analogy)

To understand this project without deep technical engineering knowledge, look at how a modern international airport security checkpoint functions:

1. **The Passenger Check-in (The Code Push Trigger)**: An engineer finishes designing a new network configuration on their laptop and pushes it to the main repository. This instantly triggers the automated security gateway.
2. **The ID & Ticket Verification (The Linux Runner Boot)**: GitHub provisions a completely clean, isolated **Ubuntu Linux Virtual Machine** in the cloud wrapper. The system clones your codebase onto this temporary runner machine.
3. **The Dress Code Compliance (Gate 1: Code Format Check)**: Runs an automated format analyzer (`terraform fmt`). It inspects the physical code spacing, tabs, and layout alignments to ensure team indentation standards are perfectly met.
4. **The Luggage Baggage Scanner (Gate 2: Static Security Scan)**: Leverages industry-standard **`tfsec`** protocols to deeply look into resource properties. If it spots a weak routing policy or open management port, it automatically throws an optimization alert.
5. **The Metal Detector Walkthrough (Gate 3 & 4: Structural Validation)**: Compiles the local resource architecture maps utilizing programmatic directory parameters (`terraform validate`). It verifies that all internal asset variables, cross-references, and bracket sequences match flawlessly before any infrastructure is deployed.

---

## ⚙️ Automated Pipeline Execution Sequence

Here is the exact linear execution path the cloud virtual worker engine runs every single time your codebase shifts:

```text
 [ Local Laptop Code Push ]
              │
              ▼ (Triggers Repository Hook)
 ┌────────────────────────────────────────────────────────┐
 │ 💻 GitHub Provisioned Linux Runner Environment Active │
 └────────────┬───────────────────────────────────────────┘
              │
              ▼
 ┌────────────────────────────────────────────────────────┐
 │ 📦 Phase 1: Code Repository Checkout & Clone           │
 └────────────┬───────────────────────────────────────────┘
              │
              ▼
 ┌────────────────────────────────────────────────────────┐
 │ 🛠️ Phase 2: Setup HashiCorp Terraform Engine Core      │
 └────────────┬───────────────────────────────────────────┘
              │
              ▼
 ╔════════════════════════════════════════════════════════╗
 ║ 🛡️ AUTOMATED COMPLIANCE & SECURITY PERIMETER GATES      ║
 ║                                                        ║
 ║   ⏩ Gate 1: Code Layout Spacing Check (`fmt`)         ║
 ║        │                                               ║
 ║        ▼                                               ║
 ║   ⏩ Gate 2: Static Security Scanning Core             ║
 ║        │                                               ║
 ║        ▼                                               ║
 ║   ⏩ Gate 3: Directory Initializations (`init`)        ║
 ║        │                                               ║
 ║        ▼                                               ║
 ║   ⏩ Gate 4: Structural Architecture Validation        ║
 ║                                                        ║
 ╚═══════════════════════════╦════════════════════════════╝
                             │
                             ▼
 ┌────────────────────────────────────────────────────────┐
 │ ✅ PIPELINE STATUS SUCCESS ──► GREEN STATUS BADGE     │
 └────────────────────────────────────────────────────────┘
```

---

## 📁 Line-by-Line YAML Schema Architecture

Our automated workflow script (`deploy.yml`) is engineered using structured properties to enforce isolation boundaries:

* **`on: push: branches: ["main"]`**: Configures the real-time event engine hooks, ensuring that any code merge triggers an instant automation sweep [GitHub Docs].
* **`runs-on: ubuntu-latest`**: Instructs the pipeline engine to spawn a completely fresh, sandboxed Linux server node to process execution parameters in total isolation [GitHub Docs].
* **`uses: actions/checkout@v3`**: Launches a modular token bridge to clone and mount your exact repository snapshot directly into the running virtual machine disk partition [GitHub Docs].
* **`terraform -chdir=01_Enterprise_Secure_Landing_Zone validate`**: Leverages the high-utility directory tracking flag (`-chdir`) [HashiCorp Learn / Developer Portal]. This forces the compiler to context-shift straight into your Project 1 network directory, preventing shell directory execution bugs and cleanly validating the infrastructure layout files [HashiCorp Learn / Developer Portal].
