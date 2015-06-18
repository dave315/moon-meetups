$(document).ready(function(){
  var meetup_path = $("form.join_meetup").attr('action');
  var meetup_match = meetup_path.match(/\d+/);
  var meetup_id = meetup_match[0];
    $.ajax({
        type: "GET",
        url: "/meetups/" + meetup_id + "/authenticate",
        dataType: "json",
        success: function(data){
          $('#join-meetup').text(data.button);
            if (data.button == "Leave"){
              var path = "/meetups/" + meetup_id + "/leave";
              var form_path = $("form.join_meetup").attr('action', path);
          } else {
              console.log("not this one")
            }
        }
      });
});
