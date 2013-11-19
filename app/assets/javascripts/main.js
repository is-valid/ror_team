jQuery(document).ready(function(){

    windov_height = document.documentElement.clientHeight;
    console.log(windov_height);

    jQuery('.welcome_l-1').css("minHeight", windov_height);
    jQuery('.welcome_l-2').css("minHeight", windov_height);
    jQuery('.welcome_l-3').css("minHeight", windov_height);

    jQuery('.Contacts_l-1').css("minHeight", windov_height);
    jQuery('.Contacts_l-2').css("minHeight", windov_height);
    jQuery('.Contacts_l-3').css("minHeight", windov_height);

    skrollr.init({
        forceHeight: false
    });

//    navigation
    jQuery("#nav a").click(function(e){
        var container;
        var destination;
        if(jQuery.browser.webkit){
            container = 'body';
        } else {
            container = 'html';
        }
        if(jQuery(this).attr("data-rel") == "Welcome"){
            destination = 0;
        } else{
            elementClick = jQuery('#'+jQuery(this).attr("data-rel"));
            destination = jQuery(elementClick).offset().top;
        }

        jQuery(container).animate({ scrollTop: destination}, 1500 );
        return false;
    })
    var offset;
    jQuery('#What_we_do .content_area .row').each(function(e){
        offset = jQuery(this).offset();
        jQuery(this).attr('data-height',offset.top);
    });

//    jQuery(window).scroll(function() {
//        scrollTop = (jQuery(document).scrollTop());
//        scrollTopPL = (jQuery(document).scrollTop()) + windov_height;
//        jQuery('.content_area .row').each(function(e){
//            if(jQuery(this).attr("data-height") < scrollTopPL - 140){
//                jQuery(this).css("opacity","1");
//            };
//            if(jQuery(this).attr("data-height") < scrollTop + 140){
//                jQuery(this).css("opacity","0.1");
//            };
//            if(jQuery(this).attr("data-height") > scrollTopPL - 140){
//                jQuery(this).css("opacity","0.1");
//            };
//
//        });
//
//
//    });

// Open modal on AJAX callback
    jQuery('.manual-ajax').click(function(event) {
        event.preventDefault();
        jQuery.get(this.href, function(html) {
//          add fixBody class for remove scroll
            jQuery("body").addClass("fixBody");
        });
    });

//  Validation of resume form fields
    jQuery(document).on ('click', '#new_resume .check_errors', function() {
      return jQuery("#new_resume").validate({
        rules: {
          "resume[email]": {
            required: true,
            email: true
          },
          "resume[name]": {
            required: true,
            maxlength: 30,
            minlength: 4
          },
          "resume[phone]": {
            required: true,
            digits: true,
            maxlength: 31
          },
          "resume[description]": {
            required: true,
            minlength: 2,
            maxlength: 3000
          },
          "recaptcha_response_field": {
            required: true
          }
        },
        messages: {
          "recaptcha_response_field": {
            required: "Captcha is required"
          }
        },
        errorPlacement: function(error, element) {
          if (element.attr('name') === 'recaptcha_response_field') {
            return error.insertAfter('#recaptcha_area');
          } else {
            return error.insertAfter(element);
          }
        }
      });
    });

//    function on modal close
    jQuery(document).on('modal:close', function(){
//      add fixBody class for remove scroll
        jQuery("body").removeClass("fixBody");
    });

    jQuery('.send_resume').click(function(event) {
        event.preventDefault();
        jQuery.get(this.href, function(html) {
//            add fixBody class for remove scroll
              jQuery("body").addClass("fixBody");
        });
    });

    jQuery('.close_send_resume').on('click', function(e) {
        e.preventDefault();
        jQuery("body").removeClass("fixBody");
    });


//    var form_errors;
//    var error_container;
//
//    jQuery(document).on('submit', '#new_resume', function(event) {
//        form_errors = jQuery.parseJSON(data.responseText);
//        error_container = '';
//        alert("Handler for .submit() called.");
//    });

//    jQuery(document).bind('ajax:success', 'form#new_resume', function(evt, data, status, xhr) {
//
//        data_new = jQuery.parseJSON(evt);
//        alert(data);
////        new_span = '';
////        jQuery.each(data_new, function(key, value) {
////          return new_span += "<div>" + (index++) + ") " + value + "</div>";
////        });
////        jQuery('form#new_resume').prepend("<div class='user_chat-notice'>" + new_span + "</div>");
//
//    });

    jQuery(document).on('ajax:success', 'form#new_resume', function(data, status, xhr) {
        jQuery('#send_new_resume').append("<div class='user_resume_notice'>" + status.notice + "</div>");
        jQuery('form#new_resume').remove();
        setTimeout(function(){
          jQuery('.close_send_resume').click();
        }, 5000);
    });

    var data_new;
    var new_span;

    jQuery(document).on('ajax:error', 'form#new_resume', function(data, status, xhr) {
        data_new = jQuery.parseJSON(data)
        alert(status.error);
        new_span = '';
        $.each(status.errors, function(key, value) {
          return new_span += "<div>" + "- " + value + "</div>";
        });
        jQuery('#send_new_resume').prepend("<div class='user_resume_errors'>" + new_span + "</div>");
    });

});