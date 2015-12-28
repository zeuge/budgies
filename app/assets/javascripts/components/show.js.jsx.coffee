@Show = React.createClass
  displayName: "Show"

  # getInitialState: ->
  #   name:       @props.value.name
  #   gender:     @props.value.gender
  #   color_id:   @props.value.color_id
  #   age:        @props.value.age
  #   tribal:     @props.value.tribal
  #   father_id:  @props.value.father_id
  #   mother_id:  @props.value.mother_id
  #
  # getDefaultProps: ->
  #   colors: []
  #   value:
  #     id:         0
  #     name:       ""
  #     gender:     true
  #     color_id:   "0"
  #     age:        0
  #     tribal:     false
  #     father_id:  0
  #     mother_id:  0
  #
  # handleSubmit: (e) ->
  #   e.preventDefault()
  #   data =
  #     id:         @props.value.id
  #     name:       @state.name
  #     gender:     @state.gender
  #     color_id:   @state.color_id
  #     age:        @state.age
  #     tribal:     @state.tribal
  #     father_id:  @state.father_id
  #     mother_id:  @state.mother_id
  #   @props.handleSubmit @props.value, data
  #
  # handleChange: (e) ->
  #   name = e.target.name
  #   if e.target.type == "checkbox"
  #     @setState "#{ name }": e.target.checked
  #   else
  #     @setState "#{ name }": e.target.value
  #
  # valid: ->
  #   {name, color_id, father_id, mother_id} = @state
  #   name && parseInt(color_id)!=0 && compareColors(@props.budgies, father_id, mother_id)
  #
  # buildOptions: (arr, label)->
  #   options = arr.map (o) ->
  #     `(<option key = {o.id} value = {o.id}>{ o.name }</option>)`
  #   options.unshift `(<option key = {0} value = {0}> --- { label } --- </option>)`
  #   options
  #
  # handleGenerateName: ->
  #   {gender, color_id, age, tribal} = @state
  #   @setState name: "#{genderText(gender)} #{getName(@props.colors, color_id)} #{age} #{tribalText(tribal)}"

  render: ->
    {name, gender, color_id, age, tribal, father_id, mother_id} = @props.value

    # colorOptions = @buildOptions(@props.colors, "Select color")
    #
    # men = @props.budgies.filter (o) ->
    #   o.gender && o.tribal && o.age >= 12
    # fatherOptions = @buildOptions(men, "no father")
    #
    # women = @props.budgies.filter (o) ->
    #   !o.gender && o.tribal && o.age >= 12
    # motherOptions = @buildOptions(women, "no mother")

    `(
      <div className = "form-horizontal">

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Name </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {name} </p>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Gender </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {genderText(gender)} </p>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Color </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {getName(this.props.colors, color_id)} </p>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Age (month) </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {age} </p>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Tribal </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {tribalText(tribal)} </p>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Father </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {getName(this.props.budgies, father_id)} </p>
          </div>
        </div>

        <div className = "form-group">
          <label className = "col-sm-2 control-label"> Mother </label>
          <div className = "col-sm-10">
            <p className = "form-control"> {getName(this.props.budgies, mother_id)} </p>
          </div>
        </div>

        <div className = "form-group">
          <div className = "col-sm-offset-2 col-sm-10">
            <a className = "btn btn-default" onClick = {this.props.handleCancel} > Cancel </a>
            <a className = "btn btn-info" onClick = {this.props.handleCancel} > Show all descendents </a>
            <a className = "btn btn-info" onClick = {this.props.handleCancel} > Show all ancestors </a>
          </div>
        </div>

      </div>
    )`
