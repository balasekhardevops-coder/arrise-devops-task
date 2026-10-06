Task 5 — Find and Fix the Bug
Below is a Terraform snippet meant to let roleB (Account A) assume roleC(Account B). It's broken. Fix it and explain in NOTES.md, in your own words, exactly why it was failing.
Plain Text
Plain Text

## Cross-Account IAM Role Configuration

```hcl
data "aws_iam_policy_document" "roleC_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::000000000000:user/roleB"
      ]
    }
  }
}

resource "aws_iam_role" "roleC" {
  name               = "roleC"
  assume_role_policy = data.aws_iam_policy_document.roleC_trust.json
}

resource "aws_iam_role_policy" "roleC_s3" {
  name = "roleC-s3-access"
  role = aws_iam_role.roleC.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}
```



# Answer


The trust policy was failing because the principal ARN identified roleB as an IAM user:

arn:aws:iam::000000000000:user/roleB

However, roleB is an IAM role, not an IAM user. IAM user and IAM role ARNs are different resource types.

The correct principal is:

arn:aws:iam::000000000000:role/roleB

roleC's trust policy now explicitly trusts roleB from Account A to call sts:AssumeRole.

Cross-account role assumption also requires roleB to have an identity-based policy allowing sts:AssumeRole on roleC. The trust policy on roleC determines who can assume the role, while roleB's permissions policy determines what roleB is allowed to assume.



