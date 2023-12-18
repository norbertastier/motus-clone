import pandas as pd

# Load Excel to DataFrame
path_excel = 'Lexique382.xlsx'
df = pd.read_excel(path_excel, engine='openpyxl')

# Convert DataFrame to JSON
json_data = df.to_json(orient='records', indent=4, force_ascii=False)

# Write JSON data to file with UTF-8 encoding
path_json = 'Lexique382.json'
with open(path_json, 'w', encoding='utf-8') as json_file:
    json_file.write(json_data)

