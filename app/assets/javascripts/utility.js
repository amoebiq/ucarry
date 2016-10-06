function authenticate(data) {

   if (data.hasOwnProperty('data')) {
       return true;
   }

    return false;


}

function setValuesinCookie(request) {
    access_token = request.getResponseHeader('Access-Token');
    access_client = request.getResponseHeader('Client');
    uid = request.getResponseHeader('Uid');
    $.cookie('Access-Token',access_token);
    $.cookie('Client',access_client);
    $.cookie('uid',uid);
}

function getAccessToken() {
    access_token = $.cookie('Access-Token');
    return access_token;

}

function getAccessClient() {
    access_client = $.cookie('Client');
    return access_client;
}

function getUid() {

    uid = $.cookie('uid');
    return uid;
}

function beforeSendSetHeader(xhr) {

    xhr.setRequestHeader('Access-Token', getAccessToken());
    xhr.setRequestHeader('Client', getAccessClient());
    xhr.setRequestHeader('Uid', getUid());
    return xhr;
}