from flask import Flask, render_template, request, jsonify
from utils import load_models, preprocess_input
import numpy as np

app = Flask(__name__)

models = load_models()

@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template('index.html')

@app.route('/sales', methods=['GET', 'POST'])
def sales():
    if request.method == 'POST':
        input_data = request.form.to_dict()
        print("USER INPUT: ", input_data)
        
        features, city, forecast_type, prediction_type = preprocess_input(input_data)
        # Error Handling
        if features.empty:
            return jsonify(error="Error: There is no data available for prediction for this specific date.  "
                           "Please select another date.")
        
        model_name = "sales_" + city + "_" + forecast_type
        model = models[model_name]
        
        print("FEATURES USED: \n")
        for ft in features:
            print(features[ft])
                
        prediction = model.predict(features)
        prediction = np.round(prediction, 0)
        
        print("MODEL USED:", model_name)
        
        return jsonify({'prediction': prediction.tolist()})
    
    return render_template('sales.html')

@app.route('/revenue', methods=['GET', 'POST'])
def revenue():
    if request.method == 'POST':
        input_data = request.form.to_dict()
        print("USER INPUT: ", input_data)
        
        features, city, forecast_type, prediction_type = preprocess_input(input_data)
        # Error Handling
        if features.empty:
            return jsonify(error="Error: There is no data available for prediction for this specific date. "
                           "Please select another date.")
        
        model_name = 'revenue' + "_" + city + "_" + forecast_type
        model = models[model_name]
        
        print("FEATURES USED: \n")
        for ft in features:
            print(features[ft])
                
        prediction = model.predict(features)
        prediction = np.round(prediction, 2)
        
        print("MODEL USED:", model_name)
        
        return jsonify({'prediction': prediction.tolist()})
    
    return render_template('revenue.html')


if __name__ == "__main__":
    app.run(debug=True)