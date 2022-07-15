
package terraform

import input.tfplan as tfplan

# Allowed sizes by provider
allowed_types = [
    "t2.nano", 
    "t2.micro"
]

array_contains(arr, elem) {
  arr[_] = elem
}

# Extracts the instance type/size
get_instance_type(resource) = instance_type {
    instance_type := resource.change.after.instance_types
}

deny[reason] {
    resource := tfplan.resource_changes[_]
    instance_type := get_instance_type(resource)
    not array_contains(allowed_types, instance_type)

    reason := sprintf(
        "%s: instance type %q is not allowed",
        [resource.address, instance_type]
    )
}