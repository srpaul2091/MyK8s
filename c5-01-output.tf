# Output Public IP
output "controlplane_public_ip" {
  description = "The Public IP address of the controlplane instance"
  value       = "ssh -i srp.pem ubuntu@${aws_instance.kubenode["controlplane"].public_ip}"
}

# Output Public IP
output "node01_public_ip" {
  description = "The Public IP address of the node01 instance"
  value       = "ssh -i srp.pem ubuntu@${aws_instance.kubenode["node01"].public_ip}"
}

# Output Public IP
output "node02_public_ip" {
  description = "The Public IP address of the node02 instance"
  value       = "ssh -i srp.pem ubuntu@${aws_instance.kubenode["node02"].public_ip}"
}

# Output Public IP
output "student_node_public_ip" {
  description = "The Public IP address of the student instance"
  value       = "ssh -i srp.pem ubuntu@${aws_instance.student_node.public_ip}"
}
