# This script requires folium and grid packages from pip:
# pip install folium grid3
#
# To use the script, enter a twin ID as the argument. It will output an html
# file containing a map of the locations of all nodes deployed by that twin

import grid3.network
import folium
from folium.plugins import MarkerCluster


def generate_node_map(twin_ids, output_file="node_map.html"):
    """Generate an interactive map showing all nodes for given twin IDs.
    
    Args:
        twin_ids: List of twin IDs to query
        output_file: Path to save the HTML map file
    """

    # Connect to the grid network
    mainnet = grid3.network.GridNetwork()

    # Get all contracts for the twin
    contracts = mainnet.graphql.nodeContracts(
        ["nodeID"], twinID_in=twin_ids, state_eq="Created"
    )
    node_ids = {c["nodeID"] for c in contracts}

    # Get node locations and countries
    nodes = mainnet.graphql.nodes(["nodeID", "location", "country"], nodeID_in=node_ids)

    if not nodes:
        print(f"No nodes found for twin IDs {twin_ids}")
        return

    # Create map centered on first node
    first_node = nodes[0]
    map_center = [
        float(first_node["location"]["latitude"]),
        float(first_node["location"]["longitude"]),
    ]

    m = folium.Map(location=map_center, zoom_start=2)
    marker_cluster = MarkerCluster().add_to(m)

    # Add markers for all nodes
    for node in nodes:
        location = node["location"]
        lat, lon = float(location["latitude"]), float(location["longitude"])
        folium.Marker([lat, lon], popup=f"Node ID: {node['nodeID']}").add_to(
            marker_cluster
        )

    # Print node and country information
    countries = {node["country"] for node in nodes if node.get("country")}
    print(f"Found {len(nodes)} nodes across {len(countries)} countries for twin IDs {twin_ids}")
    print("Countries:", ", ".join(sorted(countries)))
    m.save(output_file)
    print(f"Map saved to {output_file}")


if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: python map.py <twin_id1> [twin_id2 ...]")
        sys.exit(1)

    twin_ids = [int(arg) for arg in sys.argv[1:]]
    generate_node_map(twin_ids)
