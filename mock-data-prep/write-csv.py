import json
import csv
import argparse
import os

def json_to_csv(json_data, output_dir):
    """
    Converts each category in the JSON data (Forms, FormVersions, Questions, etc.) into separate CSV files.
    Ensures missing fields are filled with empty values.

    :param json_data: Dictionary containing extracted JSON data.
    :param output_dir: Directory where CSV files will be saved.
    """
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for category, records in json_data.items():
        if not isinstance(records, list):
            continue  # Skip non-list entries

        output_file = os.path.join(output_dir, f"{category}.csv")

        if not records:
            print(f"Skipping {category}: No data found.")
            continue

        # Collect all unique keys from every record to handle missing fields
        all_keys = set()
        for record in records:
            all_keys.update(record.keys())

        all_keys = sorted(all_keys)  # Sort keys for consistent ordering

        # Write to CSV
        with open(output_file, mode="w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=all_keys)
            writer.writeheader()
            for record in records:
                # Fill missing keys with empty strings
                writer.writerow({key: record.get(key, "") for key in all_keys})

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
