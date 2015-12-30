@Form = React.createClass
  displayName: "Form"

  getInitialState: ->
    name:       @props.value.name
    gender:     @props.value.gender
    color_id:   @props.value.color_id
    age:        @props.value.age
    tribal:     @props.value.tribal
    father_id:  @props.value.father_id
    mother_id:  @props.value.mother_id

  getDefaultProps: ->
    colors: []
    value:
      id:         0
      name:       ""
      gender:     true
      color_id:   "0"
      age:        0
      tribal:     false
      father_id:  0
      mother_id:  0

  handleSubmit: (e) ->
    e.preventDefault()
    data =
      id:         @props.value.id
      name:       @state.name
      gender:     @state.gender
      color_id:   @state.color_id
      age:        @state.age
      tribal:     @state.tribal
      father_id:  @state.father_id
      mother_id:  @state.mother_id
    @props.handleSubmit @props.value, data

  handleChange: (e) ->
    name = e.target.name
    if e.target.type == "checkbox"
      @setState "#{ name }": e.target.checked
    else
      @setState "#{ name }": e.target.value

  valid: ->
    {name, color_id, father_id, mother_id} = @state
    name && parseInt(color_id)!=0 && compareColors(@props.budgies, father_id, mother_id)

  handleGenerateName: ->
    {gender, color_id, age, tribal} = @state
    @setState name: "#{genderText(gender)} #{getName(@props.colors, color_id)} #{age} #{tribalText(tribal)}"

  render: ->
    {name, gender, color_id, age, tribal, father_id, mother_id} = @state

    colorOptions = buildOptions(@props.colors, "Select color")

    men = @props.budgies.filter (o) ->
      o.gender && o.tribal && o.age >= 12
    fatherOptions = buildOptions(men, "no father")

    women = @props.budgies.filter (o) ->
      !o.gender && o.tribal && o.age >= 12
    motherOptions = buildOptions(women, "no mother")

    `(
      <form className = "form-horizontal" onSubmit = {this.handleSubmit}>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "name">Name</label>
          <div className = "col-sm-10">
            <div className = "input-group">
              <input className = "form-control" type = "text" value = {name} name = "name" onChange = {this.handleChange} />
              <span className = "input-group-btn">
                <a className = "btn btn-default" onClick = {this.handleGenerateName}>Generate</a>
              </span>
            </div>
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
          <label className = "col-sm-2 control-label" htmlFor = "father_id">Father</label>
          <div className = "col-sm-10">
            <select className = "form-control" value = {father_id} name = "father_id" onChange = {this.handleChange} >
              {fatherOptions}
            </select>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label" htmlFor = "mother_id">Mother</label>
          <div className = "col-sm-10">
            <select className = "form-control" value = {mother_id} name = "mother_id" onChange = {this.handleChange} >
              {motherOptions}
            </select>
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
