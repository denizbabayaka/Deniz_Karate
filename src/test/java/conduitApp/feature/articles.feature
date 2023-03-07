Feature: Articles

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    Scenario: Create a new article
        Given path 'users/login'
        And  request {"user": {"email": "denizli@gmail.com","password": "12345678"}}
        When method Post
        Then status 200
        * def token = response.user.token

        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title":"nisa1","description":"gonen","body":"gonen awesome"}}
        When method Post
        Then status 200
        


      




    


    