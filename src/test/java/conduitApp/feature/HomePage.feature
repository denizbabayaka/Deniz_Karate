Feature: Test for the home page

    Scenario: Get all Tags
        Given url 'https://conduit.productionready.io/api/tags'
        When method Get
        Then status 200
        
