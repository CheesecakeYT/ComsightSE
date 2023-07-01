import requests

# VirusTotal API key
api_key = '9337869b8faa6a7aae70f6328b471d5300662b57c4b395dd32d2a85e24fa7508'  # Replace with your VirusTotal API key

csefile = 'scannedfile.txt'  # Replace with the path to your text file

with open(csefile, 'r') as file:
    scannedfile = file.read()

# API endpoint and parameters
url = 'https://www.virustotal.com/api/v3/files'
headers = {
    'x-apikey': api_key
}
params = {
    'filter': f'filename:"{scannedfile}"'
}

# Send request to VirusTotal
response = requests.get(url, headers=headers, params=params)
response_json = response.json()

# Get the number of malware detections
detections = response_json['data'][0]['attributes']['last_analysis_stats']['malicious']

# Write the results to a text file
output_file = 'output.txt'  # Replace with the path to the output text file

with open(output_file, 'w') as f:
    f.write(f'Malware detections for {scannedfile}: {detections}\n')

print(f'Scan completed. Results saved to: {output_file}')
