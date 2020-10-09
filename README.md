# README

For creating simple rails +grape +swagger app need next:<br/>

$ ```rails new rails_grape_sample_api```<br/>

Add to Gemfile<br/>
```ruby
gem 'grape'
gem 'grape-swagger'
gem 'httparty'
gem 'grape-swagger-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'webmock'
end
```
$ ```bundle install```<br/>
$ ```rails generate rspec:install```<br/>

$ ```rails g model Book title description page_count:integer```<br/>
$ ```rails g model Publisher name:string```<br/>
$ ```rails g migration AddPublisherToBook publisher:references```<br/>
$ ```rails g model Category name:string```<br/>
$ ```rails g migration CreateJoinTableBookCategory books categories```<br/>
$ ```rails db:migrate```<br/>

Add relations in models app/models<br/>

$ ```rails g controller Books```<br/>

For grape api:<br/>
Add to Gemfile:<br/>
```ruby
gem 'grape'
gem 'grape-swagger'
gem 'httparty'
gem 'grape-swagger-rails'
```
$ ```bundle install```<br/>
$ ```rails g controller Api```<br/>

Add routes description in BookController
i.e. 
```ruby
class BooksController < Grape::API
  resource :books do
    desc 'Return list of books'
    get do
      books = Book.all
      present books
    end
  end
end
```

For using Swagger:<br/>
add in your ApiController /app/controllers/api_controller.rb: ```add_swagger_documentation```<br/>
add in config/routes.rb: ```mount GrapeSwaggerRails::Engine => '/swagger'```<br/>
add file config/initializers/swagger.rb with content:<br/>
```ruby
GrapeSwaggerRails.options.url      = '/api/v1/swagger_doc.json'  
GrapeSwaggerRails.options.app_name = 'Swagger'  
GrapeSwaggerRails.options.app_url  = 'http://localhost:3000'   
```
add to app/assets/config/manifest.js :<br/>
```ruby
//= link grape_swagger_rails/application.css
//= link grape_swagger_rails/application.js 
```

For check api routes in console (gem 'grape_on_rails_routes'):<br/>
$ rake grape:routes<br/>

Run server<br/>
$ ```rails s```

For check Swagger<br/>
http://localhost:3000/swagger<br/>
