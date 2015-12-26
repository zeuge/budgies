@BudgiesRow = React.createClass
  displayName: "BudgiesRow"

  getInitialState: ->
    edit: false
    gender: @props.value.gender
    tribal: @props.value.tribal

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.checked


  handleToggle: (e) ->
    e.preventDefault()
    @setState
      edit: !@state.edit
      gender: @props.value.gender
      tribal: @props.value.tribal

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: Routes.budgy_path(@props.value.id)
      dataType: 'JSON'
      success: () =>
        @props.handleDelete @props.value

  handleEdit: (e) ->
    e.preventDefault()
    data =
      id: ReactDOM.findDOMNode(@refs.id).value
      name: ReactDOM.findDOMNode(@refs.name).value
      gender: ReactDOM.findDOMNode(@refs.gender).checked
      color_id: ReactDOM.findDOMNode(@refs.color_id).value
      age: ReactDOM.findDOMNode(@refs.age).value
      tribal: ReactDOM.findDOMNode(@refs.tribal).checked

    $.ajax
      method: 'PUT'
      url: Routes.budgy_path(@props.value.id)
      dataType: 'JSON'
      data:
        budgie: data
      success: =>
        @setState edit: false
        @props.handleEdit @props.value, data

  recordRow: ->
    {id, name, gender, color_id, age, tribal} = @props.value
    `(
      <tr>
        <td>{ id }</td>
        <td>{ name }</td>
        <td>{ gender ? " male" : " female" }</td>
        <td>{ color_id }</td>
        <td>{ age }</td>
        <td>{ tribal ? " tribal" : " no breeding" }</td>
        <td>
          <a className = "btn btn-default" onClick = {this.handleToggle}> Edit </a>
          <a className = "btn btn-danger" onClick = {this.handleDelete}> Delete </a>
        </td>
      </tr>
    )`

  recordForm: ->
    {id, name, color_id, age} = @props.value
    {gender, tribal} = @state
    `(
      <tr>
        <td><input className = "form-control" type = "number"  defaultValue = {id}   ref = "id"/></td>
        <td><input className = "form-control" type = "text"    defaultValue = {name} ref = "name"/></td>
        <td>
          <div className = "checkbox">
            <label>
              <input type = "checkbox" checked = {gender} ref = "gender" name = "gender" onChange = {this.handleChange} />
              { gender ? " male" : " female" }
            </label>
          </div>
        </td>
        <td><input className = "form-control" defaultValue = {color_id} ref = "color_id"/></td>
        <td><input className = "form-control" type = "number"  defaultValue = {age}  ref = "age"/></td>
        <td>
          <div className = "checkbox">
            <label>
              <input type = "checkbox" checked = {tribal} ref = "tribal" name = "tribal" onChange = {this.handleChange} />
              { tribal ? " yes" : " no" }
            </label>
          </div>
        </td>
        <td>
          <a className = "btn btn-default" onClick = {this.handleToggle}> Cancel </a>
          <a className = "btn btn-danger" onClick = {this.handleEdit}> Update </a>
        </td>
      </tr>
    )`

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
