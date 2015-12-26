@BudgiesRow = React.createClass
  displayName: "BudgiesRow"

  getInitialState: ->
    edit: false
    gender: @props.value.gender
    tribal: @props.value.tribal

  getDefaultProps: ->
    colors: []

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
      id: @props.value.id
      name: ReactDOM.findDOMNode(@refs.name).value
      gender: ReactDOM.findDOMNode(@refs.gender).checked
      color_id: parseInt ReactDOM.findDOMNode(@refs.color_id).value
      age: parseInt ReactDOM.findDOMNode(@refs.age).value
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

    color = @props.colors.find (c) ->
      c.id == color_id

    color_name = if !!color then color.name else ""

    `(
      <tr>
        <td>{ id }</td>
        <td>{ name }</td>
        <td>{ gender ? " male" : " female" }</td>
        <td>{ color_name }</td>
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

    renderOptions = @props.colors.map (o) ->
      `(<option key = {o.id} value = {o.id}>{ o.name }</option>)`

    `(
      <tr>
        <td>{ id }</td>
        <td><input className = "form-control" type = "text"    defaultValue = {name} ref = "name"/></td>
        <td>
          <div className = "checkbox">
            <label>
              <input type = "checkbox" checked = {gender} ref = "gender" name = "gender" onChange = {this.handleChange} />
              { gender ? " male" : " female" }
            </label>
          </div>
        </td>
        <td>
          <select className = "form-control" defaultValue = {color_id} ref = "color_id" name = "color_id" onChange = {this.handleChange} >
            { renderOptions }
          </select>
        </td>
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
