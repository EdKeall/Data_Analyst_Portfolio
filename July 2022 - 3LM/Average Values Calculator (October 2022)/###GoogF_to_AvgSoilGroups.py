#%% Import Functions
import pandas as pd
import statistics as stat

#%%

# os.chdir("""G:\Shared drives\BART PROCEDURES ED\RO HB Cluster 1 Farms\GIS Files Database\### Forms to analyser""")
# cwd = os.getcwd()  # Get the current working directory (cwd)
# files = os.listdir(cwd)  # Get all the files in that directory

#%% Load Google Forms .csv

raw = pd.read_csv('all_RO_farms_soilID_QGISexport_cleaned.csv')
# remove emptry end columns
# raw = raw.iloc[: , :-3]


#%% User is asked  to input the farm code & all soilID groups

farmcode = input("'Enter Farm Code eg.'BMH': ")

print("\nEnter the SoilID triplets for grouping")
print("(eg. '1.1 5.2 7.1'), if you have finished grouping, type 'n/a': ")

count = 1
groups={}
gcover=[]
for count in range(1,11):
    groups['G{0}'.format(count)] = input(('\nGroup {0}: ').format(count))
    
    # Stop loop and remove last entry if 'n/a' is present
    if 'n/a' in groups.values():
        del groups['G{0}'.format(count)]
        break
    gcover.append(input('''Arable 'A' or Permanent Grassland 'PG' '''))
    # Split entry into a list
    groups['G{0}'.format(count)] = groups['G{0}'.format(count)].split()

#%% Select only rows from specified farm
farmsoil = raw.loc[raw['landcode'] == farmcode]

#%% Fill out template dataframe

count = 0
template = pd.DataFrame()

for key in groups:
    itgroup = list(groups[key])
    itgroup = [float(i) for i in itgroup]
    OPgroup = farmsoil.loc[farmsoil['STMSOILID'].isin(itgroup)]
    
    # Mnum = (int(len(OPgroup)/3))
    Mnum = len(groups[key])
    for count2 in range(1,Mnum+1):
        #Need to select Mnum times of values from OPgroup, must be spaced 3 apart always
        if Mnum == 3:
            # Strata:
            templaterow = pd.Series([gcover[count],
            # Sample_ID:
            "{0}_{1}_G{2}M{3}".format(farmcode, gcover[count], count+1, count2),
            # soilIDs
            itgroup,
            # avgDepth:
            stat.mean([OPgroup.iloc[count2-1,5], OPgroup.iloc[count2+2,5], OPgroup.iloc[count2+5,5]]),
            # avg_vol:
            stat.mean([OPgroup.iloc[count2-1,6], OPgroup.iloc[count2+2,6], OPgroup.iloc[count2+5,6]]),
            # avg_C:
            stat.mean([OPgroup.iloc[count2-1,7], OPgroup.iloc[count2+2,7], OPgroup.iloc[count2+5,7]]),
            # avg_bulk:
            stat.mean([OPgroup.iloc[count2-1,8], OPgroup.iloc[count2+2,8], OPgroup.iloc[count2+5,8]])])
            
        if Mnum == 2:
            # Strata:
            templaterow = pd.Series([gcover[count],
            # Sample_ID:
            "{0}_{1}_G{2}M{3}".format(farmcode, gcover[count], count+1, count2),
            # soilIDs
            itgroup,
            # avgDepth:
            stat.mean([OPgroup.iloc[count2-1,5], OPgroup.iloc[count2+2,5]]),
            # avg_vol:
            stat.mean([OPgroup.iloc[count2-1,6], OPgroup.iloc[count2+2,6]]),
            # avg_C:
            stat.mean([OPgroup.iloc[count2-1,7], OPgroup.iloc[count2+2,7]]),
            # avg_bulk:
            stat.mean([OPgroup.iloc[count2-1,8], OPgroup.iloc[count2+2,8]])])
                
        if Mnum == 1:
            # Strata:
            templaterow = pd.Series([gcover[count],
            # Sample_ID:
            "{0}_{1}_G{2}M{3}".format(farmcode, gcover[count], count+1, count2),
            # soilIDs
            itgroup,
            # avgDepth:
            stat.mean([OPgroup.iloc[0,5], OPgroup.iloc[1,5], OPgroup.iloc[2,5]]),
            # avg_vol:
            stat.mean([OPgroup.iloc[0,6], OPgroup.iloc[1,6], OPgroup.iloc[2,6]]),
            # avg_C:
            stat.mean([OPgroup.iloc[0,7], OPgroup.iloc[1,7], OPgroup.iloc[2,7]]),
            # avg_bulk:
            stat.mean([OPgroup.iloc[0,8], OPgroup.iloc[1,8], OPgroup.iloc[2,8]])])
                
        count2 = count2 + 1
        #append row to template at end:
        template = pd.concat([template, templaterow], axis=1)
    
    count = count + 1
template = template.T
# Add column headers
template.columns = ["Strata", "Sample_ID", "Soil_IDs_used", "avgDepth",
                                 "avg_vol","avg_C", "avg_Bulk"]

#%% Export averages as .csv

filename = ('{fcode}_OVIS_Data.csv'.format(fcode=farmcode))
template.to_csv(filename,index=False)

