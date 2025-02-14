from datetime import datetime, timedelta
import json

# Constants
CONFIG_FILE = "secrets.json"
DATE_FORMAT = "%Y-%m-%d"

def load_config(file_path):
    """Load configuration from a JSON file."""
    try:
        with open(file_path, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        raise FileNotFoundError(f"Config file '{file_path}' not found.")
    except json.JSONDecodeError:
        raise ValueError(f"Invalid JSON format in '{file_path}'.")

def save_config(file_path, config):
    """Save configuration to a JSON file."""
    try:
        with open(file_path, "w") as file:
            json.dump(config, file, indent=4)  # Indent for better readability
    except IOError as e:
        raise IOError(f"Failed to write to '{file_path}': {e}")

def update_last_date(config):
    """Update the last date in the config by adding one day."""
    last_date_str = config.get("lastDate")
    if not last_date_str:
        raise KeyError("Key 'lastDate' not found in the config.")

    try:
        date_obj = datetime.strptime(last_date_str, DATE_FORMAT)
        next_date_obj = date_obj + timedelta(days=1)
        next_date_str = next_date_obj.strftime(DATE_FORMAT)
        config["lastDate"] = next_date_str
        return next_date_str
    except ValueError as e:
        raise ValueError(f"Invalid date format in 'lastDate': {e}")

def main():
    try:
        # Load the configuration
        config = load_config(CONFIG_FILE)

        # Update the last date
        next_date = update_last_date(config)

        # Save the updated configuration
        save_config(CONFIG_FILE, config)

        print(f"Last date updated to {next_date}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()