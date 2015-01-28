#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#   This operation will return a list populated with used Docker images.
#
#   Inputs:
#       - host - Docker machine host
#       - port - optional - SSH port - Default: 22
#       - username - Docker machine username
#       - password  - Docker machine password
#       - pty - whether to use pty; valid values: true, false; Default: false
#       - arguments - arguments to pass to the command; Default: none
#       - privateKeyFile - the absolute path to the private key file; Default: none
#       - timeout - time in milliseconds to wait for the command to complete; Default: 30000000 ms
#       - characterSet - character encoding used for input stream encoding from the target machine; valid values: SJIS, EUC-JP, UTF-8; Default: UTF-8;
#       - closeSession - if false the ssh session will be cached for future calls of this operation during the life of the flow
#                        if true the ssh session used by this operation will be closed; Valid values: true, false; Default: false
#   Outputs:
#       - imageList - list containing the ID's of Docker images that are used with delimiter "\n"
#   Results:
#       - SUCCESS - SSH command succeeds
#       - FAILURE - SSH command fails
####################################################

namespace: org.openscore.slang.docker.images

operations:
    - get_used_images:
         inputs:
           - host
           - port:
                default: "'22'"
           - username
           - password
           - privateKeyFile:
              default: "''"
           - command:
               default: >
                "docker ps -a | awk '{print $2}'"
               override: true
           - arguments:
                default: "''"
           - characterSet:
                default: "'UTF-8'"
           - pty:
                default: "'false'"
           - timeout:
                default: "'30000000'"
           - closeSession:
                default: "'false'"
         action:
           java_action:
             className: org.openscore.content.ssh.actions.SSHShellCommandAction
             methodName: runSshShellCommand
         outputs:
           - imageList: returnResult.replace("\n"," ").replace("ID ","",1)
         results:
           - SUCCESS
           - FAILURE