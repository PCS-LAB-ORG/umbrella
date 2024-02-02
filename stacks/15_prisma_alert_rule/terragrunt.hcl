dependencies {
  paths = ["../14_prisma_new_policy", "../13_prisma_onboard_account", "../04_kubernetes", "../03_eks_cluster", "../02_ec2", "../01_vpc"]
}

include "root" {
  path = find_in_parent_folders()
}