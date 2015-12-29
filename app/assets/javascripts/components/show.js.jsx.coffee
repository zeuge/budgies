@Show = React.createClass
  displayName: "Show"

  getInitialState: ->
    ancestors: []
    descendents: []

  showDescendents: ->
    getData "/budgies/#{@props.value.id}/descendents", (data) =>
      @setState
        ancestors: []
        descendents: data

  showAncestors: ->
    getData "/budgies/#{@props.value.id}/ancestors", (data) =>
      @setState
        ancestors: data
        descendents: []

  renderCustom: (data, header)->
    if data.length != 0
      `(<div>
          <h3>{ header }</h3>
          <Table budgies = {data}
                 colors   = {this.props.colors} />
        </div>)`

  render: ->
    {name, gender, color_id, age, tribal, father_id, mother_id} = @props.value

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
            <a className = "btn btn-info" onClick = {this.showDescendents} > Descendents </a>
            <a className = "btn btn-info" onClick = {this.showAncestors} > Ancestors </a>
          </div>
        </div>
        {this.renderCustom(this.state.descendents, "Descendents")}
        {this.renderCustom(this.state.ancestors, "Ancestors")}
      </div>
    )`
