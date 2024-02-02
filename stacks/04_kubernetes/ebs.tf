resource "helm_release" "aws-ebs-csi-driver" {
  name        = "aws-ebs-csi-driver"
  repository  = "https://charts.deliveryhero.io/"
  chart       = "aws-ebs-csi-driver"
  namespace   = "kube-system"
}