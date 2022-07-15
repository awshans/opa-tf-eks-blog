package main

deny[msg] {
	msg := data.terraform.allowed_resources.deny[_]
}

deny[msg] {
	msg := data.terraform.mandatory_tags.deny[_]
}
