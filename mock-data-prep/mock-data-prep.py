import json
import argparse
import os

# Define the fields to keep (hardcoded)
FIELDS_TO_KEEP = [
    "FormVersions.Name",
    "FormVersions.Id",
    "Questions.Id",
    "Questions.Caption__c",
    "Questions.DynamicOperationType__c",
    "Questions.DynamicOperation__c",
    "Questions.Hidden__c",
    "Questions.Hint__c",
    "Questions.Parent__c",
    "Questions.Position__c",
    "Questions.Dynamic_Operation_Test_Data__c",
    "Questions.Test_Dynamic_Operations__c",
    "Questions.RepeatSourceValue__c",
    "Questions.RepeatTimes__c",
    "Questions.Required__c",
    "Questions.SurveyVersion__c",
    "Questions.Type__c",
    "Questions.Name"
]

def extract_nested_fields(obj, fields_to_keep):
    """
    Extracts specified fields from a nested dictionary or list while preserving structure.

    :param obj: The JSON object (dict or list).
    :param fields_to_keep: A list of dot-separated field paths (e.g., "Questions.Status__c").
    :return: A new dictionary or list with only the required fields.
    """
    if isinstance(obj, list):
        return [extract_nested_fields(item, fields_to_keep) for item in obj if isinstance(item, dict)]

    result = {}
    
    # Organize fields by their top-level keys
    field_map = {}
    for field in fields_to_keep:
        parts = field.split('.')
        field_map.setdefault(parts[0], []).append('.'.join(parts[1:]))

    for key, subfields in field_map.items():
        if key in obj:
            if isinstance(obj[key], dict):
                result[key] = extract_nested_fields(obj[key], subfields)
            elif isinstance(obj[key], list):
                result[key] = [extract_nested_fields(item, subfields) for item in obj[key] if isinstance(item, dict)]
            else:
                result[key] = obj[key]

    return result

def extract_fields_from_json(input_file, output_file):
    """
    Reads a JSON file, extracts specified fields (including nested ones),
    and writes the filtered data to a new JSON file.

    :param input_file: Path to the input JSON file.
    :param output_file: Path to the output JSON file.
    """
    with open(input_file, 'r', encoding='utf-8') as f:
        data = json.load(f)  # Load JSON file (object or array)

    if isinstance(data, list):
        filtered_data = [extract_nested_fields(item, FIELDS_TO_KEEP) for item in data]
    elif isinstance(data, dict):
        filtered_data = extract_nested_fields(data, FIELDS_TO_KEEP)
    else:
        raise ValueError("Expected a JSON array or object at the root of the file.")

    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(filtered_data, f, indent=4)

def main():
    parser = argparse.ArgumentParser(description="Extract specific fields from a JSON file.")
    parser.add_argument("input_file", help="Path to the input JSON file")
    parser.add_argument("output_file", help="Path to the output JSON file")
    args = parser.parse_args()

    if not os.path.exists(args.input_file):
        print(f"Error: Input file '{args.input_file}' not found.")
        return

    extract_fields_from_json(args.input_file, args.output_file)
    print(f"Processed data written to {args.output_file}")

if __name__ == "__main__":
    main()
