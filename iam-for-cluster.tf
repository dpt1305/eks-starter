data "aws_iam_policy_document" "hkt_eks_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "hkt_cluster_role" {
    name = "hkt-cluster-role"
    assume_role_policy = data.aws_iam_policy_document.hkt_eks_policy_document.json
}

resource "aws_iam_role_policy_attachment" "hkt_eks_cluster_role_policy_attachment_1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.hkt_cluster_role.name
}

# enable Security Groups for Pods
resource "aws_iam_role_policy_attachment" "hkt_eks_cluster_role_policy_attachment_2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.hkt_cluster_role.name
}