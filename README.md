#  Project: Data-Ops Foundation

##  Objective
Deploy and automate a resilient, secure, and managed cloud data architecture on AWS—ranging from the core database infrastructure to the continuous deployment (CI/CD) pipeline and business intelligence reporting.

---

##  Architecture & Project Phases

###  Phase 1: Environment Initialization & SecOps
* **Local Setup:** Workplace configuration for an ARM-based Mac M1 architecture with Terraform and AWS CLI installed for 100% programmatic management.
* **Security (IAM):** Enforced the principle of least privilege by creating a dedicated IAM user for automated deployments.
* **State Management:** Configured a remote backend using an Amazon S3 bucket to securely store and lock the Terraform state (`tfstate`).

###  Phase 2: Networking & Isolation (VPC & Connectivity)
* **VPC:** Designed a custom isolated virtual network within the **eu-west-1 (Ireland)** region.
* **Subnets:** Built strict network segmentation featuring both public subnets and isolated private subnets to santuarize the database layer.
* **Security Groups:** Hardened firewall rules to restrict incoming and outgoing traffic exclusively to required ports (e.g., port 5432 for PostgreSQL).

###  Phase 3: Data Provisioning (RDS PostgreSQL)
* **Managed Database:** Migrated previous local Docker containers to a highly available **Amazon RDS PostgreSQL 16** instance provisioned entirely through Terraform.
* **Secrets Management:** Integrated **AWS Secrets Manager** to centralize, inject, and orchestrer sensitive credentials without ever hardcoding them into the source code.

###  Phase 4: CI/CD Automation (GitHub Actions)
* **Validation Pipeline:** Automated syntax analysis (`terraform validate` and `fmt`) triggered on every Pull Request to ensure structural compliance.
* **Deployment Pipeline:** Full GitOps setup that automatically applies infrastructure updates to AWS once changes are merged into the `main` branch.

###  Phase 5: Business Intelligence & Reporting
* **Interactive Dashboard:** Designed a dynamic analytical report using **Power BI Desktop** featuring annual/monthly sales volume tracking, product variety market share analysis (Treemaps), and geoclimatic filters.
* **Modern UI/UX:** Integrated a professional Dark Mode interface with intuitive user slicers and controls.

---

##  Technical Stack
* **Cloud Provider:** AWS (VPC, RDS, S3, Secrets Manager, IAM)
* **Infrastructure as Code (IaC):** Terraform
* **CI/CD:** GitHub Actions
* **Database Engine:** PostgreSQL 16
* **Analytics / BI:** Power BI (`.pbix`)

---

##  Repository Structure
```text
├── .github/workflows/     # CI/CD Pipelines (Validation & Deployment)
├── main.tf                # Main infrastructure configuration
├── providers.tf           # Provider settings & Terraform Backend config
├── security.tf            # Security Groups and IAM roles
├── backend_setup.tf       # Remote S3 state infrastructure
├── Dataops.pbix           # Complete Power BI Dashboard file
├── zones_benin.csv        # Geoclimatic reference data
└── README.md              # Project documentation
