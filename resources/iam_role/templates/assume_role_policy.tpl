{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "${principal_type}": "${principal_target}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}