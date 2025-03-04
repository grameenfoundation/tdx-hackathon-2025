import json
import csv
import argparse
import os

def json_to_csv(json_data, output_dir):
    """
    Converts each category in the JSON data (Forms, FormVersions, Questions, etc.) into separate CSV files.

    :param json_data: Dictionary containing extracted JSON data.
    :param output_dir: Directory where CSV files will be saved.
    """
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for category, records in json_data.items():
        if not isinstance(records, list):
            continue  # Skip if it's not a list

        output_file = os.path.join(output_dir, f"{category}.csv")
        
        if not records:
            print(f"Skipping {category}: No data found.")
            continue

        # Extract CSV headers from keys of the first record
        headers = records[0].keys()

        # Write to CSV
        with open(output_file, mode="w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=headers)
            writer.writeheader()
            writer.writerows(records)

        print(f"Saved {category} to {output_file}")

def main():
    parser = argparse.ArgumentParser(description="Convert JSON categories into separate CSV files.")
    parser.add_argument("input_json", help="Path to the input JSON file")
    parser.add_argument("output_dir", help="Directory to save CSV files")
    args = parser.parse_args()

    # Load JSON data
    with open(args.input_json, "r", encoding="utf-8") as f:
        data = json.load(f)

    json_to_csv(data, args.output_dir)

if __name__ == "__main__":
    main()
