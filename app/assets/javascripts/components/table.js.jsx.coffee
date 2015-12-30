@Table = React.createClass
  displayName: "Table"

  getDefaultProps: ->
    budgies: []
    actions: false

  handleShow: (value) ->
    @props.handleShow value

  handleEdit: (value) ->
    @props.handleEdit value

  handleDelete: (value) ->
    @props.handleDelete value

  render: ->

    renderRows = @props.budgies.map (b) =>
      `(
        <Row  key           = {b.id}
              value         = {b}
              budgies       = {_this.props.budgies}
              colors        = {_this.props.colors}
              actions       = {_this.props.actions}
              handleShow    = {_this.handleShow}
              handleEdit    = {_this.handleEdit}
              handleDelete  = {_this.handleDelete} />
      )`

    actionsHead = if @props.actions then `(<th> Actions </th>)` else null

    `(
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
            {actionsHead}
          </tr>
        </thead>
        <tbody>
          { renderRows }
        </tbody>
      </table>
    )`
