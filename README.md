# README

For creating simple rails + grape app need run:  

$ rails new rails_grape_sample_api  

Add to Gemfile  
group :development, :test do  
  gem 'rspec-rails', '~> 3.2'  
  gem ‘factory_bot_rails’  
end  

$ bundle install  
$ rails generate rspec:install  

$ rails g model Book title description page_count:integer  
$ rails db:migrate  
$ rails g controller Books  

For grape api:  
$ rails g controller Api  

Add to Gemfile:  
gem 'grape'  
gem 'grape_on_rails_routes'  
gem 'grape-swagger'  
gem 'grape-swagger-rails'  

$ bundle install  

For using swagger:   
add add_swagger_documentation in your [ApiController](https://github.com/RoR-learning/rails.grape.sample.app/blob/master/app/controllers/api_controller.rb)  
add in config/routes.rb: mount GrapeSwaggerRails::Engine => '/swagger'  
add file config/initializers/swagger.rb  
with content:  
  GrapeSwaggerRails.options.url      = '/api/v1/swagger_doc.json'  
  GrapeSwaggerRails.options.app_name = 'Swagger'  
  GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'  


For check api routes in console (gem 'grape_on_rails_routes'):  
$ rake grape:routes  
