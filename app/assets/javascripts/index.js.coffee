# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ajax:success', 'form#respond', (e, data, status, xhr) ->
    $('#url_url').val(data.surl).addClass('surl').select();
    $('.back-fa').removeClass('hide');

  $('#url_url.surl').click ->
    $(this).select();

  $('.back-fa').click ->
    $('#url_url').val('').removeClass('surl');
    $('.back-fa').addClass('hide');