Feature: Articles

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    Scenario: Create a new article
        Given path 'users/login'
        And  request {"user": {"email": "denizli@gmail.com","password": "12345678"}}
        When method Post
        Then status 200

    


    