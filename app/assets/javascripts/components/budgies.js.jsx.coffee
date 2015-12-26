@Budgies = React.createClass
  displayName: "Budgies"

  getInitialState: ->
    budgies: []
    colors: []

  componentDidMount: ->
    @getData Routes.budgies_path(), @setBudgies
    @getData Routes.colors_path(), @setColors

  getData: (path, doneHandler) ->
    $.ajax
      url: path
      dataType: "json"
    .done doneHandler
    .fail @getDataFail

  setBudgies: (data) ->
    return false unless @isMounted()
    @setState
      budgies: data

  addBudgie: (budgie) ->
    budgies = React.addons.update(@state.budgies, { $push: [budgie] })
    @setState budgies: budgies

  deleteBudgie: (budgie) ->
    index = @state.budgies.indexOf budgie
    budgies = React.addons.update(@state.budgies, { $splice: [[index, 1]] })
    @replaceState budgies: budgies

  updateBudgie: (budgie, data) ->
    index = @state.budgies.indexOf budgie
    budgies = React.addons.update(@state.budgies, { $splice: [[index, 1, data]] })
    @replaceState budgies: budgies

  setColors: (data) ->
    return false unless @isMounted()
    @setState
      colors: data

  getDataFail: (xhr, status, err) =>
    console.error @props.url, status, err.toString()

  render: ->
    renderRows = @state.budgies.map (b) =>
      `(<BudgiesRow key = {b.id} value = {b} handleDelete = {_this.deleteBudgie} handleEdit = {_this.updateBudgie}/>)`

    `(
      <div>
        <h2>Budgies</h2>
        <BudgiesNew handleNew = {this.addBudgie} />
        <table className = "table table-bordered">
          <thead>
            <tr>
              <th className = "col-sm-1"> ID </th>
              <th className = "col-sm-3"> Name </th>
              <th className = "col-sm-1"> Gender </th>
              <th className = "col-sm-3"> Color </th>
              <th className = "col-sm-1"> Age </th>
              <th className = "col-sm-1"> Tribal </th>
              <th className = "col-sm-2"> Actions </th>
            </tr>
          </thead>
          <tbody>
            { renderRows }
          </tbody>
        </table>
      </div>
    )`
