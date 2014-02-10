# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ajax:success', 'form#respond', (e, data, status, xhr) ->
    $('#url_url').val(data.surl).addClass('surl').select();
    clear('show')

  $('#url_url.surl').keydown ->
    if event.keyCode == 13
      $(this).select();

  $('#url_url.surl').keyup ->
    if $(this).val().length == 0
      clear('hide')

  $('#option').click ->


  $('#clear').click ->
    clear('hide')

  clear = (status) ->
    if status == 'hide'
      $('#url_url').val('').removeClass('surl');
      $('#clear').addClass('hide');
      $('#option').removeClass('hide');
    else if status == 'show'
      $('#clear').removeClass('hide');
      $('#option').addClass('hide');
      $('#url_url').addClass('surl')