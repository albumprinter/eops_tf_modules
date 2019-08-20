<h1>USAGE:</h1>
Module will peer the "Main" VPC from the source account with the target "Main" VPC.  
This module will not work with the Shared VPCs
 
<h2>Required Parameters:</h2>
These must be set in your call to this module:

peer_source_account_id
peer_target_account_id


<h2> Requester block workaround. </h2>
Terraform is unable to modify the requester perring connection before it is accepted.  This leaves an unhandled race condidtion where Terraform is unable to complete creating the vpc_peering_connection resource.  Removeing the requester block resolves this but leaves the connection without proper DNS.  To resolve this we do not add the dns setting in Terraform but by running the following cli post sucessful run.

*NOTE* ensure that you setup your credentials and profile before attempting to run code.

aws ec2 modify-vpc-peering-connection-options --vpc-peering-connection-id <pcx-aaaabbbb> --requester-peering-connection-options AllowDnsResolutionFromRemoteVpc=true