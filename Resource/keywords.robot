*** Settings ***
Library     OperatingSystem
Library     SeleniumLibrary
Variables   ../Data/variables.py


*** Keywords ***

Open Swag Labs
    Open Browser    ${SWAG_LABS_URL}    Chrome

Login
    [Arguments]         ${user_name}    ${password}
    Input Text          user-name       ${user_name}
    Input Password      password        ${password}
    Submit Form
    Assert logged in

Login with valid credentials
    Login    ${VALID_USERNAME}    ${VALID_PASSWORD}

Login with invalid credentials
    Input Text          user-name       ${VALID_USERNAME}
    Input Password      password        ${INVALID_PASSWORD}
    Submit Form
    Wait Until Element Contains    css:h3[data-test='error']    Epic sadface: Username and password do not match any user in this service
    
Login with locked credentials    
    Input Text          user-name       ${LOCKED_OUT_USERNAME}
    Input Password      password        ${VALID_PASSWORD}
    Submit Form
    Wait Until Element Contains    css:h3[data-test='error']    Epic sadface: Sorry, this user has been locked out.

Logout from Swag Labs
    Click Button                    css:.bm-burger-button button
    Wait Until Element Is Visible   id:logout_sidebar_link
    Click Link                      id:logout_sidebar_link

Assert logged in
    Location Should Be  ${SWAG_LABS_URL}/inventory.html

Reset application state
    Click Button                    css:.bm-burger-button button
    Wait Until Element Is Visible   id:reset_sidebar_link
    Click Link                      reset_sidebar_link

Open products page
    Go To   ${SWAG_LABS_URL}/inventory.html

Assert cart is empty
    Element Text Should Be              css:.shopping_cart_link     ${EMPTY}
    Page Should Not Contain Element     css:.shopping_cart_badge

Add product To Cart
    [Arguments]             ${product_name}
    Assert cart is empty
    Click add To Cart Button     ${product_name}
    Assert Items In Cart    1

Click add To Cart Button
    [Arguments]             ${product_name}
    ${locator}=     Set Variable    //div[@class='inventory_item'][.//div[@class='inventory_item_name ' and contains(.,${product_name})]]//button[@class='btn btn_primary btn_small btn_inventory ']
    Click Button            ${locator}

Click remove from Cart Button
    [Arguments]             ${product_name}
    ${locator}=     Set Variable    //div[@class='inventory_item'][.//div[@class='inventory_item_name ' and contains(.,${product_name})]]//button[@class='btn btn_primary btn_small btn_inventory ']
    Click Button            ${locator}
    Assert cart is empty

Assert Items In Cart
    [Arguments]             ${quantity}
    Element Text Should Be  css:.shopping_cart_badge    ${quantity}

Open cart
    Click Link          css:.shopping_cart_link
    Assert cart page

Assert cart page
    Location Should Be  ${SWAG_LABS_URL}/cart.html

Assert one product in cart
    [Arguments]             ${product}
    Element Text Should Be  css:.cart_quantity          1

Remove from cart 
    [Arguments]             ${product}
    Reset application state
    Open products page
    Add product to cart            ${product}
    Open cart
    Assert one product in cart    ${product}
    Click Element       xpath://button[contains(@class, 'btn_secondary') and contains(@class, 'btn_small') and contains(@class, 'cart_button') and text()='Remove']
    Assert cart is empty


Checkout
    [Arguments]             ${product}
    Add product to cart            ${product}
    Open cart
    Click Element                          id=checkout
    Assert checkout information page
    Input Text                          first-name      "first"
    Input Text                          last-name       "last"
    Input Text                          postal-code     10260
    Submit Form
    Assert checkout confirmation page  
    Click Element                          id=finish
    Assert checkout complete page

Assert checkout information page
    Location Should Be  ${SWAG_LABS_URL}/checkout-step-one.html
    
Assert checkout confirmation page
    Location Should Be  ${SWAG_LABS_URL}/checkout-step-two.html

Assert checkout complete page
    Location Should Be  ${SWAG_LABS_URL}/checkout-complete.html