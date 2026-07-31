# Create a Null Resource and Provisioners
resource "null_resource" "copy_ec2_keys" {
  depends_on = [aws_instance.kubenode]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_instance.kubenode["controlplane"].public_ip
    user     = "ubuntu"
    password = ""
    #private_key = file("/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/KeyPair/SRP/srp.pem")
    #private_key = file("/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/KeyPair/KKP/myTerraformKey.pem")
    private_key = file("${path.root}/keys/srp.pem")

  }

  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    #source      = "/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/KeyPair/KKP/myTerraformKey.pem" 
    source      = file("${path.root}/keys/srp.pem") #"/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/KeyPair/SRP/srp.pem"
    destination = "/tmp/eks-terraform-key.pem"
  }
  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/eks-terraform-key.pem",
      "sudo mkdir -p /d01/MyWork/AWS/SRP/MySchool/APP",
      "sudo mkdir -p /d01/MyWork/AWS/SRP/MySchool/GATE",
      "sudo mkdir -p /d01/MyWork/AWS/SRP/MySchool/INGR",
      "sudo mkdir -p /d01/MyWork/AWS/SRP/MySchool/NETPOL",
      "sudo chmod -R 777  /d01/MyWork/AWS/SRP/"
    ]
  }
  /*
  # Copies all files and folders in apps/app1 APP
  provisioner "file" {
    source      = "/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/YAML/V3/"
    destination = "/d01/MyWork/AWS/SRP/MySchool/APP"
  }

  # Copies all files and folders in apps/app1 to Gateway API 
  provisioner "file" {
    source      = "/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/YAML/V10/QUERY-REWRITE/"
    destination = "/d01/MyWork/AWS/SRP/MySchool/GATE"
  }

  # Copies all files and folders in apps/app1 to Ingress
  provisioner "file" {
    source      = "/d01/MyWork/AWS/SRP/EKS/IngressTest/"
    destination = "/d01/MyWork/AWS/SRP/MySchool/INGR"
  }

  # Copies all files and folders in apps/app1 to Network Policy
  provisioner "file" {
    source      = "/d01/MyWork/AWS/SRP/TERRAFORM/EC2/V1/YAML/V3-NetworkPolicy-02/"
    destination = "/d01/MyWork/AWS/SRP/MySchool/NETPOL"
  }
*/



  ## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  # Creation-time provisioner
  provisioner "local-exec" {
    command     = "echo  created on `date` :  >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }




}