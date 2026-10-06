All five EC2 instances are driven from a single `instances` input variable.

The root configuration uses module-level `for_each` to provision the
instances instead of defining five separate EC2 resource blocks.

Each instance has a different:

- Instance type
- Root volume type
- Root volume size
- Key pair

The `api` instance uses `io2` storage and the `prod` instance uses
`io1` storage.

## Instance Protection

The `prod` instance is protected using:

```hcl
lifecycle {
  prevent_destroy = true
}
```
