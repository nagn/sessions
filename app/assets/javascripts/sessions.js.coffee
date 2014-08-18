# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # Below is the name of the textfield that will be autocomplete
  split = (val) ->
    val.split /,\s*/
  extractLast = (term) ->
    split(term).pop()
  $("#search_student").autocomplete(
    minLength: 2
    source: (request, response) ->
      $.getJSON "/students.json",
        term: extractLast(request.term),
        session_id: $("#search_student").attr("session_id")
      ,response
      return
    search: ->
      term = extractLast(@value)
      
      false  if term.length < 2
      return
    focus: ->
      false
    select: (event, ui) ->
      user_id = ui.item.id
      session_path = $("#search_student").attr("add_student_session_path")
      $.ajax
        type: "POST"
        url: session_path
        data:
          selected_student: user_id
        beforeSend: (xhr) ->
            xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
        success: (msg) ->
      terms = split(@value)
      @value = ""
      false
  ).data("uiAutocomplete")._renderItem = (ul, item) ->
    # For now which just want to show the person.given_name in the list.
    $("<li></li>").data("item.autocomplete", item).append("<a>" + item.name + "</a>").appendTo ul
  