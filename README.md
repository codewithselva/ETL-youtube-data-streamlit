# Youtube Data Harvesting

This Python script allows you to extract, transform, and load data from YouTube using the YouTube API. The data is then stored in a MongoDB database and further transformed and loaded into a MySQL database.

## Prerequisites
Before running the script, make sure you have the following installed:

- Python
- [Google API Python Client](https://github.com/googleapis/google-api-python-client)
- [Streamlit](https://streamlit.io/)
- [Pymongo](https://pymongo.readthedocs.io/en/stable/)
- [MySQL Connector](https://pypi.org/project/mysql-connector-python/)
- [Pandas](https://pandas.pydata.org/)

Additionally, you need to obtain a YouTube API key and provide it in the script.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/codewithselva/data_science.git
   ```

2. Install the required dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Set up MongoDB:

   - Make sure you have MongoDB installed and running on your local machine.
   - The script assumes a MongoDB database named "youtube" with a collection named "channelDetails."

4. Set up MySQL:

   - Make sure you have MySQL installed and running on your local machine.
   - The script assumes a MySQL database named "youtube_harvesting" with tables named "CHANNEL," "PLAYLIST," "VIDEOS," and "COMMENT."

5. Replace the placeholder values in the script:

   - Replace the placeholder values for the YouTube API key (`youtube_api_key`) and other database connection details.

6. Run the script:

   ```bash
   streamlit run youtube_harvesting.py
   ```

## Usage

1. Enter the YouTube channel ID in the provided input box.
2. Click the "Extract" button to fetch data from the YouTube API and store it in MongoDB.
3. Click the "Transform data" button to load the transformed data into the MySQL database.
4. View the transformed data using Streamlit's user interface.

## Note

- Make sure to handle API key and database connection details securely.
- This script assumes local installations of MongoDB and MySQL. Adjust connection details accordingly for remote databases.

## Disclaimer

This script is provided as-is and may require modifications based on your specific use case or changes in the YouTube API.

---
