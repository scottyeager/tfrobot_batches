#!/bin/bash                                                                   
                                                                                
success=0                                                                     
failures=0                                                                    
                                                                                
while read -r line; do                                                        
  if [[ $line =~ mycelium_ip:\ ([0-9a-f:]+) ]]; then                          
    ip="${BASH_REMATCH[1]}"                                                   
    echo -n "Pinging $ip... "                                                 
                                                                              
    if ping -c 3 -W 1 "$ip" >/dev/null 2>&1; then                            
      echo "OK"                                                               
      ((success++))                                                           
    else                                                                      
      echo "FAILED"                                                           
      ((failures++))                                                          
    fi                                                                        
  fi                                                                          
done                                                                          
                                                                              
echo "Results: $success successful, $failures failed"
