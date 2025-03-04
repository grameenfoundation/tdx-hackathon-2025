# TaroWorks TDX-2025 Hackathon Low-Code/No-Code Javascript Writer

# Final Presentation
https://docs.google.com/presentation/d/1GLRCAWxFXTSpQPNSU_THUsi64iiU_pgt4rbfvWCqNXE/edit?usp=sharing

# Mock Data

Full Disclosure - mock data scripts were prepared ahead of time for the hackathon. All hackathon code was written during the event except for these python data-minimization scripts.

To use the python scripts:
```

python3 mock-data-prep.py original/USAID\ Monitoring\ Demo\ v1\ 2025-03-04\ 19_00_01.json minimized/usaid-sanitation-demo.json

python3 write-csv.py minimized/usaid-sanitation-demo.json csv/
Saved FormVersions to csv/FormVersions.csv

```

The final presentation used data that was not created by these scripts, but they were used during development.

# Challenges Encountered/Work Remaining

1. During data import some of the column names were garbled, these columns still appear a bit strange in the target org.
2. Other mock data was imported into the target org, these questions can be safely ignored.
3. Some partially-implemented Agents/Agent Actions/Prompt Templates are present in the org, the relevant ones have been included in this github repo. Note that in some cases both "Generic" and "Targeted" implementations were written.
4. I generally don't write much frontend code, my LWC implementation shows it 😅
5. Some of these agent actions fail during debugging but work when used in the actual Agent