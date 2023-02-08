# UFC API data download

import http.client
import requests
import pandas as pd
        
# #%%
# ##SportRadar Documentation Method

# ## I would first like to try accessing every competitors data by searching their IDs
# ## from a section of the 'season competitors' data

# # First get season IDs list

# conn = http.client.HTTPSConnection("api.sportradar.com")

# conn.request("GET", "/mma/trial/v2/en/seasons.json?api_key=pw398786wczqvrvgefa9xngm")

# res = conn.getresponse()
# data = res.read()

#%%
# Pandas Dataframe from JSON url

SeasonsNest = pd.read_json("https://api.sportradar.com/mma/trial/v2/en/seasons.json?api_key=pw398786wczqvrvgefa9xngm")


#%%
## There is a nested list 'seasons' within 'Seasons'
## Here we 'flatten' this column to get our season dataframe

Seasons = pd.json_normalize(SeasonsNest["seasons"])

#%%
## Clean 'ID' & 'competition_id' columns of file paths and convert to INT type

Seasons['id'] = Seasons['id'].str.lstrip('sr:season')
Seasons['id'] = Seasons['id'].astype('int')

Seasons['competition_id'] = Seasons['competition_id'].str.lstrip('sr:competition')
Seasons['competition_id'] = Seasons['competition_id'].astype('int')

#%% 
## Repeat this step but for the competition table

Competition_list_nested = pd.read_json("https://api.sportradar.com/mma/trial/v2/en/competitions.json?api_key=pw398786wczqvrvgefa9xngm")

#%%
## There is a nested list 'seasons' within 'Seasons'
## Here we 'flatten' this column to get our season dataframe

Competition_list = pd.json_normalize(Competition_list_nested["competitions"])

#%%
## Clean 















