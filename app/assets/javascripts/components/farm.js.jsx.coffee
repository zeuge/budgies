@Farm = React.createClass
  displayName: "Farm"

  getInitialState: ->
    budgies: []
    colors: []
    action: "index"
    budgie: @initialBudgie()

  componentDidMount: ->
    @getData Routes.budgies_path(), (data) =>
      @setState budgies: data
    @getData Routes.colors_path(), (data) =>
      @setState colors: data

  initialBudgie: ->
    id:       0
    name:     ""
    gender:   true
    color_id: "0"
    age:      0
    tribal:   false
    father_id:  0
    mother_id:  0

  getData: (path, successHandler) ->
    $.ajax
      url: path
      dataType: "JSON"
      success: successHandler

  handleNew: ->
    @setState action: "new"

  handleCreate: (budgie, data) ->
    $.ajax
      method: "POST"
      url: Routes.budgies_path()
      dataType: "JSON"
      data:
        budgie: data
      success: (data) =>
        budgies = React.addons.update(@state.budgies, { $push: [data] })
        @setState
          budgies: budgies
          action: "index"

  handleCancelCreate: ->
    @setState action: "index"

  handleShow: (budgie) ->
    @setState
      action: "show"
      budgie: budgie

  handleCancelShow: (budgie) ->
    @setState
      action: "index"
      budgie: @initialBudgie()

  handleEdit: (budgie) ->
    @setState
      action: "edit"
      budgie: budgie

  handleCancelEdit: ->
    @setState
      action: "index"
      budgie: @initialBudgie()

  handleUpdate: (budgie, data) ->
    $.ajax
      method: "PUT"
      url: Routes.budgy_path(budgie.id)
      dataType: "JSON"
      data:
        budgie: data
      success: =>
        index = @state.budgies.indexOf budgie
        budgies = React.addons.update(@state.budgies, { $splice: [[index, 1, data]] })
        @setState
          budgies: budgies
          action: "index"
          budgie: @initialBudgie()

  handleDelete: (budgie) ->
    $.ajax
      method: "DELETE"
      url: Routes.budgy_path(budgie.id)
      dataType: "JSON"
      success: () =>
        index = @state.budgies.indexOf budgie
        budgies = React.addons.update(@state.budgies, { $splice: [[index, 1]] })
        @setState budgies: budgies

  renderTable: ->
    renderRows = @state.budgies.map (b) =>
      `(
        <Row  key           = {b.id}
              value         = {b}
              budgies       = {_this.state.budgies}
              colors        = {_this.state.colors}
              handleShow    = {_this.handleShow}
              handleEdit    = {_this.handleEdit}
              handleDelete  = {_this.handleDelete} />
      )`

    `(
      <div>
        <h2>Budgies</h2>
        <a className = "btn btn-primary" onClick = {this.handleNew}> New </a>
        <table className = "table table-bordered">
          <thead>
            <tr>
              <th> ID </th>
              <th> Name </th>
              <th> Gender </th>
              <th> Color </th>
              <th> Age </th>
              <th> Tribal </th>
              <th> Father </th>
              <th> Mother </th>
              <th> Actions </th>
            </tr>
          </thead>
          <tbody>
            { renderRows }
          </tbody>
        </table>
      </div>
    )`

  render: ->
    render = switch @state.action
      when "new"
         `(<Form  value         = {this.state.budgie}
                  budgies       = {this.state.budgies}
                  colors        = {this.state.colors}
                  buttonLabel   = "Create"
                  handleSubmit  = {this.handleCreate}
                  handleCancel  = {this.handleCancelCreate} />)`
      when "edit"
        `(<Form  value         = {this.state.budgie}
                 budgies       = {this.state.budgies}
                 colors        = {this.state.colors}
                 buttonLabel   = "Update"
                 handleSubmit  = {this.handleUpdate}
                 handleCancel  = {this.handleCancelEdit} />)`
      when "show"
        `(<Show  value         = {this.state.budgie}
                 budgies       = {this.state.budgies}
                 colors        = {this.state.colors}
                 buttonLabel   = "Update"
                 handleCancel  = {this.handleCancelShow} />)`
      else
        @renderTable()

    `(
      <div>
        <h1>Farm</h1>
        { render }
      </div>
    )`
