//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('.unfollow-btn').hover(function (){
  $(this).text('Unfollow?');
  $(this).removeClass('btn-primary');
  $(this).addClass('btn-danger');
}, function() {
  $(this).text('Following...');
  $(this).removeClass('btn-danger');
  $(this).addClass('btn-primary');
  });
});
