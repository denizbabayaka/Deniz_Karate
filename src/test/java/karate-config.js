function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: "https://conduit.productionready.io/api/"
  };
  if (env == 'dev') {
     config.userEmail = 'denizlili@gmail.com'
     config.userPassword = '12345678'
  } else if ( 'qa') {
    // customize
  }
  return config;
}