```
git pull https://github.com/awshans/opa-tf-eks-blog.git

cd opa-tf-eks-blog/terraform

terraform plan -out tfplan
terraform show -json tfplan > tfplan.json

cd ..

opa eval --format pretty --data rules/ --input ../terraform/tfplan.json "data.terraform"
```