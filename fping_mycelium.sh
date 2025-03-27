#!/bin/bash                                                                   
                                                                              
TIMEOUT=10000
success=0                                                                     
failures=0                                                                    
ips=()                                                                        
                                                                              
while read -r line; do                                                        
  if [[ $line =~ mycelium_ip:\ ([0-9a-f:]+) ]]; then                          
    ips+=("${BASH_REMATCH[1]}")                                               
  fi                                                                          
done                                                                          
                                                                              
if (( ${#ips[@]} > 0 )); then                                                 
  results=$(fping -c3 -t$TIMEOUT "${ips[@]}" 2>&1)                                
  while read -r line; do                                                      
    if [[ $line =~ ^([0-9a-f:]+)\ :\ xmt/rcv/%loss\ =\ [0-9]+/[0-9]+/([0-9]+) ]]; then
      loss="${BASH_REMATCH[2]}"                                               
      echo -n "Pinging $ip... "                                               
      if (( loss == 0 )); then                                                
        echo "OK"                                                             
        ((success++))                                                         
      else                                                                    
        echo "FAILED"                                                         
        ((failures++))                                                        
      fi                                                                      
    fi                                                                        
  done <<< "$results"                                                         
fi                                                                            
                                                                              
echo "Results: $success successful, $failures failed" 
