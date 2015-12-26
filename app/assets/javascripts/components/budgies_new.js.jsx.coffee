@BudgiesNew = React.createClass
  displayName: "BudgiesNew"

  getInitialState: ->
    id:       ""
    name:     ""
    gender:   true
    color_id: 0
    age:      0
    tribal:   false

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

  render: ->
    {id, name, gender, color_id, age, tribal} = @state

    `(
      <form onSubmit = {this.handleSubmit}>

        <div className = "form-group col-sm-1">
          <label className = "control-label" htmlFor = "id"> ID </label>
          <input className = "form-control" type = "number" value = {id} name = "id" placeholder = "ID" onChange = {this.handleChange} />
        </div>

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

        <div className = "form-group col-sm-3">
          <label>Color:</label>
          <input className = "form-control" value = {color_id} name = "color_id" placeholder="Color ID" onChange = {this.handleChange} />
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
          <button className = "btn btn-primary"> Create </button>
        </div>
      </form>
    )`



          # <label>
          #   Gender (click) :
          #   {gender ? " male" : " female"}
          #   <input type = "checkbox" checked = {gender} name = "gender" onChange = {this.handleChange} hidden />
          # </label>
