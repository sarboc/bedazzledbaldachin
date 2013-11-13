# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#add-player').click ->
    event.preventDefault()
    $phone = $("#phone").val()
    $name = $("#name").val()
    console.log $phone
    console.log $name
    params = { player: { phone: $phone, name: $name}}

    $.post("/players", params).done (data) ->
      $('#player-list').append('<li>' + $name + ': ' + $phone + '</li>' )




