
<% %>
<div class="panel-heading">
    <h3 class="panel-title">Create your Poll</h3>
</div>
  
<div class="panel-body">

<table id="createPoll" class="table table-striped table-hover table-condensed">
  <thead>
    <tr>
      <th class="col-md-1"></th>
      <th class="col-md-3">
      	<div class="form-group">
        	<input type="text" class="form-control" id="title" placeholder="Type a title here...">
      	</div>
      </th>
      <th class="col-md-8">
      	<div class="form-group">
        	<input type="text" class="form-control" id="question" placeholder="Type your question here...">
      	</div>
      </th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <td class="col-md-1">
		
      </td>
      <td class="col-md-3">
      	<div class="form-group">
        	<button id="addOption" class="btn btn-primary btn-sm">New option</button>
      	</div>
      	<div class="form-group">
		<div class="radio">
        <label>
			<input type="radio" name="options" value="captcha" >
            Require captcha?
        </label>
        </div>
		</div>
		<div class="form-group">
		<div class="radio">
        <label>
			<input type="radio" name="options" value="vat" checked>
            Require VAT?
        </label>
        </div>
		</div>
		<div class="form-group">
        	<button id="backBtn" class="btn btn-default">Back</button>
        	<button id="createBtn" class="btn btn-primary">Create Poll</button>
      	</div>
      </td>
      <td class="col-md-8">
      	<div id="errorDiv" class="alert alert-dismissible alert-danger">
  		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  		<span id="erSpan">Poll wasn't created please try again.</span>
	  	</div>
      </td>
    </tr>
  </tfoot>
  <tbody>
    <tr>
      <td class="col-md-1">1</td>
      <td class="col-md-3">
      	<div class="form-group">
        	<input type="text" class="form-control" id="1" placeholder="Enter poll option...">
    	</div>
      </td>
      <td class="col-md-8"></td>
    </tr>
    <tr>
      <td class="col-md-1">2</td>
      <td class="col-md-3">
      	<div class="form-group">
        	<input type="text" class="form-control" id="2" placeholder="Enter poll option...">
      	</div>
      </td>
      <td class="col-md-8"></td>
    </tr>
    <tr>
      <td class="col-md-1">3</td>
      <td class="col-md-3">
      	<div class="form-group">
        	<input type="text" class="form-control" id="3" placeholder="Enter poll option...">
      	</div>
      </td>
      <td class="col-md-8"></td>
    </tr>
    <tr>
      <td class="col-md-1">4</td>
      <td class="col-md-3">
      	<div class="form-group">
        	<input type="text" class="form-control" id="4" placeholder="Enter poll option...">
      	</div>
      </td>
      <td class="col-md-8"></td>
    </tr>
  </tbody>
</table>

</div>