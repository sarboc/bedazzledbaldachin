# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#add-player').click ->
    event.preventDefault()
    $phone = $("#phone").val()
    $name = $("#name").val()
    $event_id = $("#event_id").val()
    params = { player: { phone: $phone, name: $name, event_id: $event_id}}
    $("#name").val("")
    $("#phone").val("")

    $.post("/players", params).done (data) ->
      # getUsers($event_id)

  $('#start-party').click ->
    $event_id = $('#start-party').val()
    $.ajax( '/events/' + $event_id,
      type: 'PUT'
    ).done (data) ->
      alert "You've started the party!"
  # getUsers = (event_id) ->
  #   console.log event_id
  #   $.ajax( '/events/'+ event_id + '.json',
  #   method: 'GET'
  #   ).done (data) ->
  #     for item in data
  #       $('#player-list').append('<li>' + item.name + ': ' + item.phone + '</li>' )