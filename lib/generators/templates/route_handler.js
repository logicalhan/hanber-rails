<%= application_name.camelize %>.<%= class_name %>Route = Ember.Route.extend({
  renderTemplates: function() {
    this.render('<%= class_name.underscore %>');
  },
  setupControllers: function(controller) {

  },
  enter: function() {
    console.log("entering <%= class_name.underscore %> route")
  }
});