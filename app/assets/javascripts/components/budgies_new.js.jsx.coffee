@BudgiesNew = React.createClass
  displayName: "BudgiesNew"

  getInitialState: ->
    name:     ""
    gender:   true
    color_id: "0"
    age:      0
    tribal:   false

  getDefaultProps: ->
    colors: []

  handleChange: (e) ->
    name = e.target.name
    if e.target.type == "checkbox"
      @setState "#{ name }": e.target.checked
    else
      @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post Routes.budgies_path(), { budgie: @state }, (data) =>
      @props.handleNew data
      @setState @getInitialState()
    , 'JSON'

  valid: ->
    @state.name && @state.color_id != "0"

  render: ->
    {name, gender, color_id, age, tribal} = @state

    renderOptions = @props.colors.map (o) ->
      `(<option key = {o.id} value = {o.id}>{ o.name }</option>)`
    renderOptions.unshift `(<option key = {0} value = {0}> --- Select color --- </option>)`

    `(
      <form onSubmit = {this.handleSubmit}>

        <div className = "form-group col-sm-3">
          <label className = "control-label" htmlFor = "name"> Name </label>
          <input className = "form-control" type = "text" value = {name} name = "name" placeholder = "Name" onChange = {this.handleChange} />
        </div>

        <div className = "form-group col-sm-1">
          <label className = "control-label" htmlFor = "gender"> Gender </label>
          <div className = "checkbox">
            <label>
              <input type = "checkbox" checked = {gender} name = "gender" onChange = {this.handleChange} />
              {gender ? " male" : " female"}
            </label>
          </div>
        </div>

        <div className = "form-group col-sm-4">
          <label>Color:</label>
          <select className = "form-control" value = {color_id} name = "color_id" onChange = {this.handleChange} >
            {renderOptions}
          </select>

        </div>

        <div className = "form-group col-sm-2">
          <label>Age (month):</label>
          <input className = "form-control" type = "number" value = {age} name = "age" placeholder="Age" onChange = {this.handleChange} />
        </div>

        <div className = "form-group col-sm-1">
          <label className = "control-label" htmlFor = "tribal"> Tribal </label>
          <div className = "checkbox">
            <label>
              <input type = "checkbox" checked = {tribal} name = "tribal" onChange = {this.handleChange} />
              {tribal ? " yes" : " no"}
            </label>
          </div>
        </div>

        <div className = "form-group col-sm-1">
          <button className = "btn btn-primary" disabled = {!this.valid()}> Create </button>
        </div>
      </form>
    )`
