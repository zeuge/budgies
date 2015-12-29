@getData = (path, successHandler) ->
  $.ajax
    url: path
    dataType: "JSON"
    success: successHandler


@genderText = (gender) ->
  if gender then " male" else " female"

@tribalText = (tribal) ->
  if tribal then " tribal" else " no breeding"

@findById = (array, id) ->
  find = array.find (a) ->
    a.id == parseInt(id)
  if !!find then find else false

@getName = (array, id) ->
  find = @findById(array, id)
  return "" unless find
  find.name

@compareColors = (array, id1, id2) ->
  return true if parseInt(id1) == 0 && parseInt(id2) == 0 # if no parents

  find1 = @findById(array, id1)
  return false unless find1

  find2 = @findById(array, id2)
  return false unless find2

  parseInt(find1.color_id) == parseInt(find2.color_id)
