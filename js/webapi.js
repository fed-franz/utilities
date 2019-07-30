var request = require('request');
/*
Example: https://chain.api.btc.com/v3/block/latest/tx
	url = 'http://api.website.org/v3/'
	endpoint = block/latest/tx
*/

/* POST */
function postToApi (api_url, api_endpoint, json_data, callback) {
  console.log(api_endpoint+': ', JSON.stringify(json_data));
  request.post({
      url: api_url+api_endpoint,
      headers: {'Content-Type': 'application/json'},
      form: json_data
  },
  function (error, response, body) {
      if (error) {
          return callback(error);
      }
      if (typeof body === 'string') {
          body = JSON.parse(body)
      }
      console.log('Status: ', response.statusCode);
      console.log('Body: ', JSON.stringify(body, null, 2));
      return callback(null, body);
  });
}

/* GET */
function getFromApi (api_url, api_endpoint, param, callback) {
    request.get(api_url+api_endpoint+'/'+param, function (error, response, body) {
        if (error) return callback(error);

        if (typeof body === 'string')
            body = JSON.parse(body)

        console.log('Status:', response.statusCode);
        console.log('Body: ', JSON.stringify(body, null, 2));
        return callback(null, body);
    });
}

/* EXPORT */
module.exports = {
  getFromApi: getFromApi,
  postToApi: postToApi
}
