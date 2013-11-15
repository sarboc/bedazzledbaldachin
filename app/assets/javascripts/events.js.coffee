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
      status = "Accepted" if item.accepted == true
      status = "Pending" if item.accepted == false
      $('#player-list').append('<tr>' + '<th>' + item.name + '</th><th>' + item.phone + '</th><th>' + status + '</th>' )

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

  $('#player-list').each ->
    checkPlayers()
    setInterval () ->
      checkPlayers()
      console.log "The setinterval is running"
    , 10000