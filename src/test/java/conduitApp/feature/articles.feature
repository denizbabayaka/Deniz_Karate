
Feature: Articles

    Background: Define URL
          Given url apiUrl
        # Given path 'users/login'
        # And  request {"user": {"email": "denizlili@gmail.com","password": "12345678"}}
        # When method Post
        # Then status 200
        # * def token = response.user.token
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') 
        # * def token = tokenResponse.authToken
        

    Scenario: Create a new article
        # Given header Authorization = 'token ' + token
        Given path 'articles'
        * configure ssl = true
        When method Post  
        And request {"article": {"tagList": [],"title": "Daniell","description": "fff","body": "fff"}}
        Then status 200
        And match response.article.title == "Daniell"

    Scenario: Create and Delete article
        # Given header Authorization = 'Token ' + token
        When method Post
        Given path 'articles'  
        And request {"article": {"tagList": [],"title": "Delete Article","description": "fff","body": "fff"}}
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.article[0].title == 'Delete Article'

        # Given header Authorization = 'Token ' + token
        Given path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.article[0].title !== 'Delete Article'


        


      




    


    