# Debugging a Flask Application

To set breakpoints and debug a Flask app without tests we need to:
1. Create a debug launch configuration for a Flask application in VS Code
2. Run the app using the new launch configuration
3. Add breakpoints
4. Use postman to hit the endpoints where we've added our breakpoints

This guide will cover the first 2 steps to get you up and running!

## Create a Debug Launch Configuration

1. To create a new launch configuration in VS Code, press the "Run" menu at the top of the screen and choose the option "Add Configuration"
    ![VS Code UI showing the Run menu open and the Add Configuration option highlighted](assets/debug_flask_without_tests/add_config_1_vscode_run_add_configuration.png)
    _Fig. Screenshot of VS Code's UI showing the `Run` menu open and the `Add Configuration` option highlighted. ([Full size image](assets/debug_flask_without_tests/add_config_1_vscode_run_add_configuration.png))_

2. In the new menu that appears, select "More Python Debugger options..."
    ![VS Code UI showing a dropdown from the code window that has the option "More Python Debugger options..." highlighted](assets/debug_flask_without_tests/add_config_2_more_python_options.png)
    _Fig. Screenshot of VS Code's UI showing a dropdown from the code window that has the option "More Python Debugger options..." highlighted. ([Full size image](assets/debug_flask_without_tests/add_config_2_more_python_options.png))_

3. A new menu will appear, and we want to press the option: "Python Debugger: Flask hello-books-api"
    ![VS Code UI showing a dropdown from the code window displaying all Python Debugger options with an arrow pointing to "Python Debugger: Flask hello-books-api"](assets/debug_flask_without_tests/add_config_3_python_debugger_flask.png)
    _Fig. Screenshot of VS Code's UI showing a dropdown from the code window displaying all Python Debugger options with an arrow pointing to "Python Debugger: Flask hello-books-api". ([Full size image](assets/debug_flask_without_tests/add_config_3_python_debugger_flask.png))_

4. After step 3, we will be shown a new file with the launch.json that VS Code generated for us. We can safely close this file once it is created.
    ![VS Code UI showing the generated launch.json file](assets/debug_flask_without_tests/add_config_4_generated_flask_debug_configuration.png)
    _Fig. Screenshot of VS Code's UI showing the generated launch.json file. ([Full size image](assets/debug_flask_without_tests/add_config_4_generated_flask_debug_configuration.png))_

    The full text of the launch.json file we generated is below:
    ```py
    {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Python Debugger: Flask",
                "type": "debugpy",
                "request": "launch",
                "module": "flask",
                "env": {
                    "FLASK_APP": "app/__init__.py",
                    "FLASK_DEBUG": "1"
                },
                "args": [
                    "run",
                    "--no-debugger",
                    "--no-reload"
                ],
                "jinja": true
            }
        ]
    }
    ```

## Run the App Using the Launch Configuration

Now that we've created a debug launch configuration for our Flask app, we can run our app using the launch configuration to ensure that VS Code starts our application rather than trying to run a single route file.

1. 