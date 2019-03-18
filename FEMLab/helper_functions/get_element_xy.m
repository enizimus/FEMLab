function [xe, ye] = get_element_xy(nodes, e_nodes)
xe = [nodes(e_nodes).x];
ye = [nodes(e_nodes).y];