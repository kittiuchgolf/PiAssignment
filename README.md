# PiAssignment

This project automates the testing of a To-Do List web application using Robot Framework and SeleniumLibrary.

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/kittiuchgolf/bluepi-assignment
   ```

2. Install required dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Download the [web driver](https://selenium.dev/documentation/webdriver/getting_started/installing_browser_drivers) for your browser and place it in the project's root directory.

## Test Execution

Run the tests using the following command:

```bash
robot -d Results Test/testTodoList.robot
```
