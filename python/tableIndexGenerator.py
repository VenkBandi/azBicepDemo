import json

# Constants
SECRETS_FILE = "secrets.json"
OUTPUT_FILE = "numbers.txt"
MAX_NUMBERS = 12

def load_secrets():
    """Load the secrets.json file and return its content."""
    try:
        with open(SECRETS_FILE, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        raise FileNotFoundError(f"File '{SECRETS_FILE}' not found.")
    except json.JSONDecodeError:
        raise ValueError(f"Invalid JSON format in '{SECRETS_FILE}'.")

def save_secrets(data):
    """Save the updated data back to secrets.json."""
    try:
        with open(SECRETS_FILE, "w") as file:
            json.dump(data, file, indent=4)
    except IOError as e:
        raise IOError(f"Failed to write to '{SECRETS_FILE}': {e}")

def generate_numbers(start, count):
    """Generate a list of numbers starting from `start`."""
    return list(range(start, start + count))

def save_numbers_to_file(numbers, output_file):
    """Save the generated numbers to a text file."""
    try:
        with open(output_file, "w") as file:
            for number in numbers:
                file.write(f"{number}\n")
    except IOError as e:
        raise IOError(f"Failed to write to '{output_file}': {e}")

def main():
    try:
        # Load the secrets.json file
        secrets = load_secrets()

        # Get the current performanceIndex
        performance_index = secrets.get("performanceIndex", 0)

        # Generate numbers from performanceIndex + 1 to performanceIndex + 12
        start_number = performance_index + 1
        numbers = generate_numbers(start_number, MAX_NUMBERS)

        # Save the numbers to a text file
        save_numbers_to_file(numbers, OUTPUT_FILE)

        # Update the performanceIndex
        secrets["performanceIndex"] = performance_index + MAX_NUMBERS

        # Save the updated secrets.json file
        save_secrets(secrets)

        print(f"Generated numbers: {numbers}")
        print(f"Updated performanceIndex to {secrets['performanceIndex']}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()