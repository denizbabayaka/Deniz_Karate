Feature: Test for the home page

    Background: Define URL
        Given url apiUrl


    Scenario: Get all Tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['ipsum', 'qui']
        And match response.tags !contains 'truck'
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page 
        Given path 'articles'
        Given params { limit: 10, offset: 0}
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 197

     