# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $event_id = $('#event_id').val()

  ajaxRequest = (type) ->
    $.ajax( "/events/#{$event_id}.json",
      type: type
    )

  updatePlayerList = (data) ->
    $('#player-list').empty()
    for item in data
      $('#player-list').append('<li>' + item.name + ': ' + item.phone + '</li>' )

  checkPlayers = () ->
    ajaxRequest("GET").done (data) ->
      updatePlayerList(data)

  $('#add-player').click ->
    event.preventDefault()
    $phone = $("#phone").val()
    $name = $("#name").val()
    params = { player: { phone: $phone, name: $name, event_id: $event_id}}
    $("#name").val("")
    $("#phone").val("")

    $.post("/players", params).done ->
      updatePlayerList ajaxRequest("GET")

  $('#start-party').click ->
    ajaxRequest("PUT")
    alert "You've started the party!"

  checkPlayers()
  setInterval () ->
   checkPlayers()
  , 5000
