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
    {id, name, gender, color_id, age, tribal, father_id, mother_id} = @props.value
    {budgies, colors} = @props

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
        <td>
          <a className = "btn btn-default" onClick = {this.handleEdit}> Edit </a>
          <a className = "btn btn-danger" onClick = {this.handleDelete}> Delete </a>
        </td>
      </tr>
    )`
