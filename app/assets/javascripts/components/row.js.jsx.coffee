@Row = React.createClass
  displayName: "Row"

  getDefaultProps: ->
    colors: []

  handleDelete: (e) ->
    e.preventDefault()
    @props.handleDelete @props.value

  handleEdit: (e) ->
    e.preventDefault()
    @props.handleEdit @props.value

  render: ->
    {id, name, gender, color_id, age, tribal} = @props.value

    color = @props.colors.find (c) ->
      c.id == parseInt(color_id)
    color_name = if !!color then color.name else ""

    `(
      <tr>
        <td>{ id }</td>
        <td>{ name }</td>
        <td>{ genderText(gender) }</td>
        <td>{ color_name }</td>
        <td>{ age }</td>
        <td>{ tribalText(tribal) }</td>
        <td>
          <a className = "btn btn-default" onClick = {this.handleEdit}> Edit </a>
          <a className = "btn btn-danger" onClick = {this.handleDelete}> Delete </a>
        </td>
      </tr>
    )`
