user_data = <<-EOT
  #!/bin/bash
  apt-get update -y
  apt-get install -y curl
  /bin/bash ${path.module}/scripts/k3s_install.sh
  /bin/bash ${path.module}/scripts/cloudwatch_install.sh
EOT
