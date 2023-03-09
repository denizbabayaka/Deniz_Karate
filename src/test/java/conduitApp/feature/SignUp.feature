Feature: Sign Up 


    Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    Given url apiUrl 


 @debug
    Scenario:Sign Up new User 
        Given def userData = {"email":"danielil@gmail.com","username":"denizKarate"}

      
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

@parallel=false
    Scenario Outline: Validate Sign Up error messages
        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                | password  | username               | errorResponse                                                                      |  
            | #(randomEmail)       | Karate123 | KarateUser123          | {"errors":{"username":["has already been taken"]}}                                 |
            | KarateUser1@test.com | Karate123 | #(randomUsername)      | {"errors":{"email":["has already been taken"]}}                                    |
            | KarateUser1          | Karate123 | #(randomUsername)      | {"errors":{"email":["is invalid"]}}                                                |
            | #(randomEmail)       | Karate123 | KarateUser123123123123 | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                 | 
            | #(randomEmail)       | Kar       | #(randomUsername)      | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                 | 
            |                      | Karate123 | #(randomUsername)      | {"errors":{"email":["can't be blank"]}}                                            | 
            | #(randomEmail)       |           | #(randomUsername)      | {"errors":{"password":["can't be blank"]}}                                         |
            | #(randomEmail)       | Karate123 |                        | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}} |        
