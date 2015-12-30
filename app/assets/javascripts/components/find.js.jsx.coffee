@Find = React.createClass
  displayName: "Find"

  getInitialState: ->
    id:         ""
    name:       ""
    gender:     ""
    color_id:   ""
    age:        ""
    tribal:     0
    filtered: []

  getDefaultProps: ->
    colors: []
    budgies: []

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleFind: ->
    data = {}
    data["id"] = @state.id if @state.id
    data["name"] = @state.name if @state.name
    data["gender"] = @state.gender if @state.gender
    data["color_id"] = @state.color_id if @state.color_id
    data["age"] = @state.age if @state.age
    data["tribal"] = @state.tribal if @state.tribal

    $.ajax
      url: "/budgies"
      dataType: "JSON"
      data: data
      success: (data) =>
        @setState filtered: data

  handleClearAll: ->
    @setState @getInitialState

  renderTable: (data)->
    if data.length != 0
      `(<Table budgies = {data}
               colors   = {this.props.colors} />)`

  render: ->
    {id, name, gender, color_id, age, tribal} = @state

    colorOptions = buildOptions(@props.colors, "All colors", "")

    arrGender = [{id: true, name: "Male"}, {id: false, name: "Female"}]
    genderOptions = buildOptions(arrGender, "All", "")

    arrTribal = [{id: true, name: "Tribal"}, {id: false, name: "No breeding"}]
    tribalOptions = buildOptions(arrTribal, "All", "")

    `(<div className = "form-horizontal">
        <div className = "form-group">
          <label className = "col-sm-2 control-label"> ID </label>
          <div className = "col-sm-10">
            <input className = "form-control" type = "number" value = {id} name = "id" onChange = {this.handleChange} />
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Name </label>
          <div className = "col-sm-10">
            <input className = "form-control" type = "text" value = {name} name = "name" onChange = {this.handleChange} />
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Gender </label>
          <div className = "col-sm-10">
            <select className = "form-control" value = {gender} name = "gender" onChange = {this.handleChange} >
              { genderOptions }
            </select>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Name </label>
          <div className = "col-sm-10">
            <select className = "form-control" value = {color_id} name = "color_id" onChange = {this.handleChange} >
              { colorOptions }
            </select>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Age </label>
          <div className = "col-sm-10">
            <input className = "form-control" type = "number" value = {age} name = "age" onChange = {this.handleChange} />
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Tribal </label>
          <div className = "col-sm-10">
            <select className = "form-control" value = {tribal} name = "tribal" onChange = {this.handleChange} >
              { tribalOptions }
            </select>
          </div>
        </div>

        <div className = "form-group">
          <div className = "col-sm-offset-2 col-sm-10">
            <button className = "btn btn-primary" onClick = {this.handleFind} > Find </button>
            <a className = "btn btn-default" onClick = {this.props.handleCancel} > Cancel </a>
            <a className = "btn btn-default" onClick = {this.handleClearAll} > Clear all </a>
          </div>
        </div>
        { this.renderTable(this.state.filtered) }
      </div>)`
