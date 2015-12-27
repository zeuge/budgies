@Form = React.createClass
  displayName: "Form"

  getInitialState: ->
    name:     @props.value.name
    gender:   @props.value.gender
    color_id: @props.value.color_id
    age:      @props.value.age
    tribal:   @props.value.tribal

  getDefaultProps: ->
    colors: []
    value:
      id:       0
      name:     ""
      gender:   true
      color_id: "0"
      age:      0
      tribal:   false

  handleSubmit: (e) ->
    e.preventDefault()
    data =
      id:       @props.value.id
      name:     @state.name
      gender:   @state.gender
      color_id: @state.color_id
      age:      @state.age
      tribal:   @state.tribal
    @props.handleSubmit @props.value, data

  handleChange: (e) ->
    name = e.target.name
    if e.target.type == "checkbox"
      @setState "#{ name }": e.target.checked
    else
      @setState "#{ name }": e.target.value

  valid: ->
     @state.name && parseInt(@state.color_id)!=0

  render: ->
    {name, gender, color_id, age, tribal} = @state

    colorOptions = @props.colors.map (o) ->
      `(<option key = {o.id} value = {o.id}>{ o.name }</option>)`
    colorOptions.unshift `(<option key = {0} value = {0}> --- Select color --- </option>)`

    `(
      <form onSubmit = {this.handleSubmit}>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "name">Name</label>
          <div className = "col-sm-10">
            <input className = "form-control" type = "text" value = {name} name = "name" onChange = {this.handleChange} />
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "gender">Gender</label>
          <div className = "col-sm-10 checkbox">
            <label>
              <input type = "checkbox" checked = {gender} name = "gender" onChange = {this.handleChange} />
              { genderText(gender) }
            </label>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "color_id">Color</label>
          <div className = "col-sm-10">
            <select className = "form-control" value = {color_id} name = "color_id" onChange = {this.handleChange} >
              {colorOptions}
            </select>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "age">Age (month)</label>
          <div className = "col-sm-10">
            <input className = "form-control" type = "number" value = {age} name = "age" onChange = {this.handleChange} />
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "tribal">Tribal</label>
          <div className = "col-sm-10 checkbox">
            <label>
              <input type = "checkbox" checked = {tribal} name = "tribal" onChange = {this.handleChange} />
              { tribalText(tribal) }
            </label>
          </div>
        </div>

        <div className = "form-group">
          <div className = "col-sm-offset-2 col-sm-10">
            <button className = "btn btn-primary" disabled = {!this.valid()}>{this.props.buttonLabel}</button>
            <a className = "btn btn-default" onClick = {this.props.handleCancel} > Cancel </a>
          </div>
        </div>
      </form>
    )`
