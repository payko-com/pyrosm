import pandas as pd
import geopandas as gpd
from pyrosm._arrays cimport concatenate_dicts_or_arrays


cpdef create_nodes_gdf(node_dict_list):
    nodes = concatenate_dicts_or_arrays(node_dict_list)
    df = pd.DataFrame()
    for k, v in nodes.items():
        df[k] = v
    df['geometry'] = gpd.points_from_xy(nodes['lon'], nodes['lat'])
    return gpd.GeoDataFrame(df, crs='epsg:4326')


cpdef create_gdf(data_records, geometry_array):
    datasets = [v for v in data_records.values()]
    keys = list(data_records.keys())
    df = pd.DataFrame()
    for i, key in enumerate(keys):
        df[key] = datasets[i]
    df['geometry'] = geometry_array
    return gpd.GeoDataFrame(df, crs='epsg:4326')
