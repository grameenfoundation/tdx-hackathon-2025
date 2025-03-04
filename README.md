# tdx-hackathon-2025
TDX Hackathon 2025

# Mock Data

Full Disclosure - this mock data script was prepared ahead of time for the hackathon. All hackathon code was written during the event except for these python data-minimization scripts.

To use the python scripts:
```

python3 mock-data-prep.py original/USAID\ Monitoring\ Demo\ v1\ 2025-03-04\ 19_00_01.json minimized/usaid-sanitation-demo.json

python3 write-csv.py minimized/usaid-sanitation-demo.json csv/
Saved FormVersions to csv/FormVersions.csv

```

# Challenges Encountered/Work Remaining

1. During data import some of the column names were garbled, these columns still appear a bit strange in the target org.
2. Other mock data was imported into the target org, these questions can be safely ignored.
3. Some partially-implemented Agents/Agent Actions/Prompt Templates are present in the org, the relevant ones have been included in this github repo.
4. I generally don't write much frontend code, my LWC implementation shows it 😅
5. Some of these agent actions fail during debugging but work when used in the actual Agent