Feature: Test for the home page

    Background: Define URL
        Given url apiUrl


    Scenario: Get all Tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['ipsum', 'qui']
        And match response.tags !contains 'truck'
        And match response.tags contains any ['fish','dog','SIDA']
        And match response.tags contains only ['fish','dog','SIDA']
        And match response.tags == "#array"
        And match each response.tags == "#string"
        And match response == {"articles":"#array","articlesCount":197}
        #looking certain value of articles array from createdAt tags  
        And match response.articles[0]createdAt contains '2020'
        #it will look any favoritesCount tag inside array and find value 1
        And match response.article[*].favoriteCount contains 1
        And match response.article[*].author.bio contains null 
        # 2 dots will look inside whole array an find all bio keys 
        And match each  response..bio contains null 
        And match each  response..following == false 
        # assert the structure of value from folloeing tag 
        And match each response..following == '#boolean'
        And match each response..fovoritesCount == '#number'
        # it will assert 2 diffrent structure of bio key 
        And match each response..bio == '##string'
       

    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator')

        Given path 'articles'
        Given params { limit: 10, offset: 0}
        When method Get
        Then status 200
        #lenght of 10 
        And match response.articles == '#[10]'
        And match response.articlesCount == 197
        And match response.articlesCount != 100
        #assert the data of whole article  array schema validation 
        And match each response.articles ==
        """
            {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? timeValidator(_)",  #we use the timeValidator method here line34 
                "updatedAt": "#? timeValidator(_)",
                "tagList": "#array",
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                },
                "favorited": '#boolean',
                "favoritesCount": '#number'
            }
        """

    Scenario: Conditional logic
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def favoriteCount = response.articles[0].favoritesCount
        * def article = response.articles[0] 

        * if(favoritesCount == 0)karate.call('classpath:helpers/AddLikes.feature' article)

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.article[0].fovoritesCount == 1 