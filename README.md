Pro-Vision App

	1 - Description:
The Pro-Vision App is a cutting-edge solution designed to address the challenges that organizations face in predicting product demand and forecasting sales or revenue. Leveraging the power of MS SQL and Python, this full-stack data science application is invaluable for inventory management, supply chain optimization, and workforce planning.

The Pro-Vision App aims to solve these issues by deploying 16 machine learning models, namely gradient boosting algorithms. These models use past sales data to make predictions based on different combinations of city, store, sales/revenue prediction, and daily or weekly forecast types.

Key Features and Benefits
 - Demand Prediction
 - Revenue Prediction
 - User Friendly Interface

	2 - Installation Instructions:

Follow these step-by-step instructions to install and run the Pro-Vision App on your local machine:

 a. Open Command Prompt in Directory:

Navigate to the Pro-Vision App directory where the project is located.
In the address bar, enter " cmd ", and the command prompt will open with the Pro-Vision App directory path.

 b. Create Virtual Environment: 
Navigate to the Pro-Vision App directory, open the command prompt within this directory, and create a virtual environment by entering: " py -m venv .env "

 c. Activate Virtual Environment:

Type " .\.env\Scripts\activate " and press Enter to activate the virtual environment.

 d. Install Required Packages:

You will need to install the necessary packages for the app to function properly.
Type " pip install -r requirements.txt " and press Enter to install the packages listed in the requirements.txt file. Please note that this process might take some time, depending on your system configuration.

 e. Run the Application:

Type " flask run " and press Enter to start the application.
You will see the HTTP address displayed in the command prompt. Press Ctrl and click on the address, and it will open the website in your default browser.

 f. Access the App:

The app will now run locally, and you can access all its features through your web browser.

	3 - Usage Instructions:

Follow these detailed instructions to make the most of the Pro-Vision App's features:

 a. Access the Homepage:

Click the HTTP address provided after running the application to access the homepage of the app.

 b. Select Prediction Type:

Choose between two types of predictions: Sales (Demand) Prediction or Revenue Prediction by clicking the corresponding button.

 c. Configure Prediction Settings (e.g., for Demand Prediction):

You will be directed to the relevant page based on your choice (e.g., /sales route for demand prediction).
Here, you can configure the following settings:

City: Select the desired city from the dropdown.

Store: Once the city is selected, choose a store from the updated list of stores in that city.

Forecast Type: Choose between daily or weekly forecasts.

Date: Select a date within the range of 2017-01-02 to 2019-10-31, as data is available only for these dates.

 d. Weekly Forecast Adjustment:

If you select "weekly" as the forecast type, note that any date chosen will automatically be adjusted to the Monday of the same week.
Weekly predictions represent the total number of items sold or total revenue expected for that entire week.

 e. Get Prediction:

Click the "Predict" button, and the prediction result will be displayed on the page.
The steps are the same for both demand prediction and revenue prediction.

 f. Understanding the Results:

Interpret the prediction result based on your business needs, utilizing the insights provided by the app.

 g. Navigation and Repeat:

You can navigate back to the homepage or other sections to make additional predictions as needed.

	Note: You can follow the flow of application using the command prompt. As you click "Predict" button, various information will be printed on the command prompt about the flow. 

	4 - File Structure:

The Pro-Vision App directory is organized into several key folders and files, each serving a specific purpose in the application. Here's an overview of the structure:

.README.txt: This file provides detailed documentation about the application, including instructions for installation, usage, and other essential information.

requirements.txt: This file lists the versions of packages required for running the app. It's used in conjunction with pip to ensure that the correct dependencies are installed.

.env: A directory containing files necessary to run the virtual environment. This setup isolates the dependencies and allows the app to run consistently across different machines.

app: The main directory containing the application code and related assets.

   __pycache__: Stores compiled versions of Python scripts (.pyc files), which help in quicker execution.

   models: Houses 16 machine learning models in .joblib file format. These models are loaded by the Flask app for making predictions.
	
   static: Contains styles.css file, which holds the CSS code used for designing and styling the application.

   templates: Includes index.html, revenue.html, and sales.html files. These HTML files define the structure and content of each page on the website.

   app.py: The main file that contains the Flask application's main method and route definitions.

   utils.py: Contains code for various functions such as connecting to the database, loading machine learning models, and preprocessing user input.

	5 - Error Handling:

 a. Date Range Validation:

If a user selects a date outside the range of available data (2017-01-02 to 2019-10-31), the application will display an error message: "Error: The selected date is outside the available data range. Please choose a date between 2017-01-02 and 2019-10-31."

 b. Data Availability Check:

When making a prediction, the application queries the database for historical data. If the database returns an empty dataframe for the selected date (e.g., due to missing data for that specific date), the application will display an error message: "Error: There is no data available for prediction for this specific date. Please select another date."

 c. Weekly Forecast Date Adjustment:

If the user selects a weekly forecast and the chosen date is not a Monday, the application will automatically adjust the date to the corresponding Monday of the same week. If the chosen date is already a Monday, the application will use it as is.

	6 - Dependencies:

The list of libraries and dependencies can be found in the requirements.txt file.
