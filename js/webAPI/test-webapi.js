/* test.js */
'use strict';

const webapi = require('./webapi')

var args = process.argv.slice(2);
var op = args[0]
var api_url = args[1]

/*
e.g.:
var api_baseurl = "https://bitnodes.earn.com/api/v1/"
var api_endpoint = "snapshots"
var param = "latest"

api_url+'/'+api_endpoint+'/'+param
*/

if(op === 'get'){
  webapi.getFromApi(api_url, function (error, result) {
    if (error) console.log(error);

    console.log('Body: ', JSON.stringify(result, null, 2));
    // var info = JSON.parse(result)
  })
}

if(op === 'post'){  
  var data = args[2]

  webapi.postToApi(api_url, data, function(error, result){
    if (error) console.log(error);

    console.log('Body: ', JSON.stringify(result, null, 2));
  })
}
