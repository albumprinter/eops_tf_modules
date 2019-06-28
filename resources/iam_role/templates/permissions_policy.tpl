{
  "Version": "2012-10-17",
  "Statement": [
  %{ for statement in policy_statements ~}
    {
      "Effect": "${statement["Effect"]}",
      "Action": [
        %{ for action in statement["Action"] ~}
        "${action}"%{ if index(statement["Action"], action) < length(statement["Action"]) - 1},%{ endif ~}
        %{ endfor ~}
      ],
      "Resource": [
        %{ for resource in statement["Resource"] ~}
        "${resource}"%{ if index(statement["Resource"], resource) < length(statement["Resource"]) - 1},%{ endif ~}
        %{ endfor ~}
      ]
    }%{ if index(policy_statements, statement) < length(policy_statements) - 1},%{ endif ~}
  %{ endfor ~}
  ]
}