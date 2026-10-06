Task 3 — Multi-Account IAM & Cross-Account Access
Account A (000000000000):
•	Group group1 for CLI/programmatic-only access. 
Members: engine, ci.
•	Group group2 for full console + CLI access. 
Members: two named users of your choice.
•	roleA: administrative access to all AWS services except IAM.
•	roleB: a role whose only permission is to assume a role in Account B.
Account B (111111111111):
•	roleC: full access to a single named S3 bucket, assumable only byroleB from Account A — not by anything else in Account A.

# NOTES

## 1. Would you give engine and ci IAM users with access keys in a real production setup?

No. In a real production environment, I would avoid long-lived IAM user access keys wherever possible.

For a human engineer, I would normally use AWS IAM Identity Center with SSO and short-lived credentials instead of permanent access keys.

For CI/CD workloads, I would use workload identity federation such as OIDC. The CI/CD system can authenticate to AWS and assume an IAM role through AWS STS, receiving temporary credentials instead of storing long-lived AWS access keys in pipeline secrets.

Long-lived access keys introduce additional security and operationalrisk because they must be securely stored, rotated, monitored, and revoked if compromised.


## 2. Why does it matter whether roleC trusts Account A root or roleB's specific ARN?

If roleC trusts:

arn:aws:iam::000000000000:root

it establishes trust with Account A at the account level. This does not mean that only the AWS root user can assume roleC. Account A can potentially delegate permission to its IAM identities to assume roleC.

That is broader than the requirement.

The requirement states that roleC must be assumable only by roleB.
Therefore, roleC should trust:

arn:aws:iam::000000000000:role/roleB

This restricts the trust relationship to the specific role.

For cross-account AssumeRole access, both sides must allow the operation:

1. roleB's identity-based policy allows sts:AssumeRole on roleC.
2. roleC's trust policy trusts roleB.

Both conditions must be satisfied for roleB to assume roleC.

