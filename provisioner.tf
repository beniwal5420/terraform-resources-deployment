resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "/bin/bash ${path.module}/ansible/script.sh"
  }
  depends_on = [
    module.vmlinux,
    module.vmwindows,
    module.datadisk,
    module.database,
  ]
}
