
#Creating key pair for SSH
resource "aws_key_pair" "T3_KEY" {
  key_name   = "key"
  public_key = file("key.pub")
}


resource "aws_instance" "T3_EC2" {
  key_name                    = aws_key_pair.T3_KEY.key_name
  ami                         = var.ami_id
  instance_type               = var.inst_type
  vpc_security_group_ids      = [aws_security_group.T3_SECURITY_GROUP.id]
  subnet_id                   = aws_subnet.T3_SUBNET.id
  associate_public_ip_address = true
  user_data                   = file("nginx.sh")

  tags = {
    Name = "T3_EC2"
  }SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM user;
SET FOREIGN_KEY_CHECKS = 1;

}
