@Row = React.createClass
  displayName: "Row"

  getDefaultProps: ->
    colors: []

  handleShow: (e) ->
    e.preventDefault()
    @props.handleShow @props.value

  handleEdit: (e) ->
    e.preventDefault()
    @props.handleEdit @props.value

  handleDelete: (e) ->
    e.preventDefault()
    @props.handleDelete @props.value

  render: ->
    {id, name, gender, color_id, age, tribal, father_id, mother_id} = @props.value
    {budgies, colors, actions} = @props

    actions = if actions
      `(<td>
        <a className = "btn btn-default" onClick = {this.handleShow}> Show </a>
        <a className = "btn btn-warning" onClick = {this.handleEdit}> Edit </a>
        <a className = "btn btn-danger" onClick = {this.handleDelete}> Delete </a>
      </td>)`
    else
      ""

    `(
      <tr>
        <td>{ id }</td>
        <td>{ name }</td>
        <td>{ genderText(gender) }</td>
        <td>{ getName(colors, color_id) }</td>
        <td>{ age }</td>
        <td>{ tribalText(tribal) }</td>
        <td>{ getName(budgies, father_id) }</td>
        <td>{ getName(budgies, mother_id) }</td>
        { actions }
      </tr>
    )`
