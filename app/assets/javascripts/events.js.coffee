# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

_
$ ->
  $event_id = $('#event_id').val()
  playerInfo = _.template('<tr><td><%= item.name %></td><td><%= item.phone %></td><td><%= item.accepted ? "Accepted" : "Pending" %></td></tr>')

  ajaxRequest = (type) ->
    $.ajax( "/events/#{$event_id}.json",
      type: type
    )

  updatePlayerList = (data) ->
    $('#player-list table tbody').empty()
    for item in data
      # status = "Accepted" if item.accepted == true
      # status = "Pending" if item.accepted == false
      $('#player-list table tbody').append(playerInfo({item: item}))

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

    $.post("/players", params).done (data) ->
      $('#player-list table tbody').append(playerInfo({item: data}))

  $('#party-start-btn').click ->
    event.preventDefault()
    ajaxRequest("PUT")
    $('#party-start-btn').addClass("hide")
    $('#party-stop-btn').removeClass("hide")

  $('#player-list').each ->
    checkPlayers()
    setInterval () ->
      checkPlayers()
    , 10000

  $('label').click ->
    $(this).addClass('active')
    $(this).siblings('.rating').removeClass('active')
    $(this).siblings('.leder').removeClass('hidden')


