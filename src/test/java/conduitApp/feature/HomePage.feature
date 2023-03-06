Feature: Test for the home page

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'


    Scenario: Get all Tags
        Given path 'tags'
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page 
        Given path 'articles'
        Given params { limit: 10, offset: 0}
        When method Get
        Then status 200