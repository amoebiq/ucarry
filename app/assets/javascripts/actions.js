
function signin(){


    username = $('#signin_email').val();
    password = $('#signin_password').val();

    $.ajax({


        url: "/auth/sign_in",
        type: "POST",
        data: {"email" : username , "password" : password},
        dataType: "json",
        success: function(data, textStatus, request){
            alert(data['data']['email']);
            alert(authenticate(data));
            setValuesinCookie(request);
            $("#error_signin").hide();

        },

        error: function(data, textStatus, request){

            alert('falses');
            $("#error_signin").show();
        }
    });


};

function orders() {

    access_token = getAccessToken();
    access_client = getAccessClient();
    uid = getUid();

    alert(access_token + ' '+uid);

    $.ajax({

        url: "/sender/sender1474301273/orders",
        type: "GET",
        dataType: "json",
        beforeSend: function(xhr){
            beforeSendSetHeader(xhr);
        },
        success: function(data, textStatus, request){

            alert(data);
        }
    });

};

