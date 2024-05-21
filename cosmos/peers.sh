#!/bin/bash
#############################################
### http://$RPC_ADDRESS:14657/net_info
### 14657 = port RPC
#############################################
# IP address of another node
PEER_NODE="IP_ADDRESS_OF_ANOTHER_NODE"

# Function to fetch active peers from RPC
function get_peers {
    local RPC_ADDRESS=$1
    curl -s http://$RPC_ADDRESS:14657/net_info | jq -r '.result.peers[] | select(.remote_ip != "0.0.0.0") | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr | split(":")[1])"'
}

# Number of retries
RETRIES=5
LOCAL_PEERS=""
REMOTE_PEERS=""

# Fetching active peers from the local node
for ((i=1; i<=RETRIES; i++))
do
    echo "Attempt $i of $RETRIES for the local node"
    NEW_LOCAL_PEERS=$(get_peers "localhost")
    LOCAL_PEERS=$(echo -e "$LOCAL_PEERS\n$NEW_LOCAL_PEERS" | sort -u)
    sleep 1 # Pause between requests
done

# Fetching active peers from the remote node
echo "Fetching peers from the remote node"
REMOTE_PEERS=$(get_peers "$PEER_NODE")

# Combining peer lists and removing duplicates
ALL_PEERS=$(echo -e "$LOCAL_PEERS\n$REMOTE_PEERS" | sort -u | grep -v "0.0.0.0" | tr '\n' ',' | sed 's/^,//' | sed 's/,$//')

# Checking if peers are retrieved
if [ -z "$ALL_PEERS" ]; then
    echo "No active peers were retrieved from the RPC endpoints."
else
    # Displaying active peers
    echo -e "\nActive Peers:\n$ALL_PEERS"
    
    # Saving active peers to peersnode.txt file
    echo -e "$ALL_PEERS" > peersnode.txt
    echo -e "\nPeers list saved to peersnode.txt"
fi
