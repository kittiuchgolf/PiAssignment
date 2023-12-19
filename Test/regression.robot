*** Settings ***
Documentation   Regression test file
Resource        ../Resource/keywords.robot

*** Test Cases ***
TC02
    [Setup]    Open Swag Labs
    Login with invalid credentials
    [Teardown]      Close Browser

TC05
    [Setup]    Open Swag Labs
    Login with locked credentials  
    [Teardown]      Close Browser

TC06
    [Setup]    Open Swag Labs
    Login with valid credentials
    Logout from Swag Labs 
    [Teardown]      Close Browser 

TC14
    [Setup]    Open Swag Labs
    Login with valid credentials
    Add product to cart     "Sauce Labs Backpack"
    [Teardown]      Close Browser  

TC17
    [Setup]    Open Swag Labs
    Login with valid credentials
    Remove from cart     "Sauce Labs Bike Light"
    [Teardown]      Close Browser  

TC21
    [Setup]    Open Swag Labs
    Login with valid credentials
    Checkout    "Sauce Labs Bike Light"
    [Teardown]      Close Browser  