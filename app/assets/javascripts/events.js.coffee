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
    $('#player-list table tbody').empty()
    for item in data
      status = "Accepted" if item.accepted == true
      status = "Pending" if item.accepted == false
      $('#player-list table tbody').append('<tr>' + '<td>' + item.name + '</td><td>' + item.phone + '</td><td>' + status + '</td></tr>' )

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

  $('#party-btn').click ->
    btn = $('#party-btn')
    if btn.data("status") is "start"
      btn.data("status", "end")
      btn.removeClass("btn-success")
      btn.addClass("btn-danger")
      btn.text("End the party")
      ajaxRequest("PUT")
    else if btn.data("status") is "end"
      btn.data("status", "start")
      btn.addClass("btn-success")
      btn.removeClass("btn-danger")
      btn.text("Start the party again!")
      ajaxRequest("PUT")

  $('#player-list').each ->
    checkPlayers()
    setInterval () ->
      checkPlayers()
    , 10000
