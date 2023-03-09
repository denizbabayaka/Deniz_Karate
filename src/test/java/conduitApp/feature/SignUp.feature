Feature: Sign Up 


    Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given url apiUrl 


 @debug
    Scenario:Sign Up new User 
        Given def userData = {"email":"danielil@gmail.com","username":"denizKarate"}

        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * configure ssl = true                    
        Given path 'users'
        # And request {"user":{"email":"#(userData.email)","password":"12345678","username":"#(userData.username)"}}
        And request
        """
            {
                "user": {
                    "email": "#(randomEmail)", # those atre coming fromdataGenerator 
                    "password": "123Karate123",
                    "username": "#(randomUsername)"
                }
            }
        """
        When method Post
        Then status 422
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": "#(randomEmail)",
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": "#(randomUsername)",
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """
