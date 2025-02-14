import subprocess
import sys

# List of Python files to run in sequence
scripts = ["incrementDate.py","performanceIndexGenerator.py", "mockData.py", "sendData.py"]

def run_script(script):
    """Run a Python script using subprocess."""
    try:
        print(f"Running {script}...")
        result = subprocess.run([sys.executable, script], check=True)
        print(f"{script} completed successfully.")
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error: {script} failed with exit code {e.returncode}.")
        return False
    except FileNotFoundError:
        print(f"Error: {script} not found.")
        return False

def main():
    """Run all scripts in sequence."""
    for script in scripts:
        if not run_script(script):
            print(f"Stopping execution due to failure in {script}.")
            break
    else:
        print("All scripts executed successfully.")

if __name__ == "__main__":
    main()