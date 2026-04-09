# common

Shared resources used across all btg-case-studies-with-dbt repositories.

## setup/
Platform setup guides. Start here before cloning any environment repo.
- `1_stack_setup_mac.md` — Mac setup (Git, Docker, VS Code, uv, dbt, gh)
- `1_stack_setup_windows.md` — Windows WSL2 setup (coming soon)
- `1_stack_setup_linux.md` — Linux setup (coming soon)

## database_scripts/
Bronze layer SQL scripts — one file per case study.
Each file contains CREATE TABLE statements and INSERT INTO statements.
Run these after starting the Docker stack to populate the bronze layer.

| File | Case study | Business model |
|---|---|---|
| `resource_utilization.sql` | Resource utilization | Pay-as-you-go |
| `milestone_achievement.sql` | Milestone achievement | Pay-as-you-go |
| `subscription_management.sql` | Subscription management | Subscription |
