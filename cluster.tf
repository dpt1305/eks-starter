resource "aws_eks_cluster" "hkt_cluster" {
  name     = "hkt_cluster"
  role_arn = aws_iam_role.hkt_cluster_role.arn

  vpc_config {
    subnet_ids = [
        aws_subnet.hkt_one.id, 
        aws_subnet.hkt_two.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.hkt_eks_cluster_role_policy_attachment_1,
    aws_iam_role_policy_attachment.hkt_eks_cluster_role_policy_attachment_2,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.hkt_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.hkt_cluster.certificate_authority[0].data
}