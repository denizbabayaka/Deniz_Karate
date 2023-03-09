function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  } 
  if (env == 'dev') {
     config.userEmail = 'denizlili@gmail.com'
     config.userPassword = '12345678'
  }  
  if (env == 'qa') {
    config.userEmail = "deniz@gmail.com"
    config.userPassword = "12345678"
  }

    var accessToken = karate.callSingle(
      "classpath:helpers/CreateToken.feature",
      config
    ).authToken;
    karate.configure("headers", { Authorization: "Token " + accessToken });
  return config;
}

