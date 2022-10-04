import pandas as pd
import numpy as np

template = pd.DataFrame(columns=["Farm", "Landcode", "Field number",
                                 "Field name","Area (ha)", "RPA Land Use"])

FarmName = input("Enter Farm Name:")
FarmCode = input("Enter Farm Code (case-sensitive):")

raw = pd.read_csv('%s_FieldNameForm.csv' % (FarmCode))

rows = len(raw['parcelId'])
print(rows, "rows")

FarmNameArr = np.tile(FarmName, rows)
FarmCodeArr = np.tile(FarmCode, rows)

template['Farm'] = FarmNameArr.tolist()
template['Landcode'] = FarmCodeArr.tolist()
template['Field number'] = (raw["parcelId"]).tolist()
template['Field name'] = (raw["FIELDNAME"]).tolist()
template['Area (ha)'] = (raw["area"]).tolist()
template['RPA Land Use'] = (raw["descriptio"]).tolist()

formname = ('%s_FieldNameForm' % (FarmCode))
formname = (formname + ' - %s.csv' % (FarmName))
template.to_csv(formname,index=False)
