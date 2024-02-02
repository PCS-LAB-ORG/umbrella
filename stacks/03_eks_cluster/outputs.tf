output "eks_cluster_id" {
  value = "${aws_eks_cluster.Umbrella-EKS-Cluster.id}"
}

output "eks_cluster_endpoint" {
  value = "${aws_eks_cluster.Umbrella-EKS-Cluster.endpoint}"
}


output "eks_cluster_certificate" {
  value = "${aws_eks_cluster.Umbrella-EKS-Cluster.certificate_authority.0.data}"
}

output "eks_cluster_name" {
  value = "${aws_eks_cluster.Umbrella-EKS-Cluster.name}"
}


output "aws_eks_node_group_Umbrella-EKS-NodeGrp_id" {
  value = "${aws_eks_node_group.Umbrella-EKS-NodeGrp.id}"
}
