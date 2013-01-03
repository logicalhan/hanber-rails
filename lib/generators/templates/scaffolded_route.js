<%= application_name.camelize %>.<%= @rest_action.camelize %>Route = Ember.Route.extend({
  renderTemplates: function() {
    this.render('<%= @rest_action.underscore %>');
  },
  setupControllers: function(controller) {

  },
  enter: function() {
    console.log("entering <%= @rest_action.underscore %> route")
  }
});