Feature: Articles

    Background: Define URL
        # Given url 'https://api.realworld.io/api/'
        # Given path 'users/login'
        # And  request {"user": {"email": "denizlili@gmail.com","password": "12345678"}}
        # When method Post
        # Then status 200
        # * def token = response.user.token
        * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
        * def token = tokenResponse.authToken
        
 @ignore
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'  
        And request {"article": {"tagList": [],"title": "jfjb2","description": "fff","body": "fff"}}
        When method Post
        Then status 200
        And match response.article.title == 'jfjb2'
@debug
    Scenario: Create and Delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles'  
        And request {"article": {"tagList": [],"title": "Delete Article","description": "fff","body": "fff"}}
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.article[0].title == 'Delete Article'

        Given header Authorization = 'Token ' +token
        Given path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.article[0].title !== 'Delete Article'


        


      




    


    