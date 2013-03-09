# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  message = $("#message")
  tr = $("#commits").find("tr")
  tr.bind "click", (event) ->
    values = ""
    tds = $(this).addClass("row-highlight").find("td")
    $.each tds, (index, item) ->
      if index == 0
       $('#package_commit_id').val(item.innerHTML.replace(/^\s+|\s+$/g, '')) 

    message.html values