class BooksController < Grape::API
  resource :books do
    desc 'Return list of books'
    get do
      books = Book.all
      present books
    end

    desc 'Return a book searched by title'
    params do
      requires :title_part, type: String, desc: 'Search text in title.'
    end
    get 'search' do
      # p "!!! " + "test = " + params[:title_part]
      Book.where("title LIKE ?", '%'+params[:title_part]+'%')
    end

    desc 'Return a specific book'
    params do
      requires :id, type: String, desc: 'Book ID.'
    end
    get ':id' do  # /api/v1/books/{:id}
      Book.find(params[:id])
    end
    # route_param :id do # /api/v1/books/{:id}
    #   get do
    #     Book.find(params[:id])
    #   end
    # end

    desc 'Create new book'
    params do
      requires :book, type: Hash, desc: 'Your book.' do
        requires :title, type: String, desc: 'Title of a book.'
        optional :description, type: String, desc: 'Description of a book.'
        optional :page_count, type: Integer, desc: 'Page count of a book.'
      end
      requires :publisher, type: Hash, desc: 'Book publisher' do
        requires :name, type: String, desc: 'Publisher name'
      end
      optional :categories, type: Array, desc: 'List of categories.',
               documentation: {param_type: 'body'} do
      end
    end
    post '/' do
      categories = []
      params[:categories]&.each { |c| categories << Category.find_or_create_by(name: c) }
      publisher = Publisher.find_or_create_by!(params[:publisher])
      Book.create!(params[:book].merge(publisher: publisher, category_ids: categories.collect(&:id)))
    end

    desc 'Update a book.'
    params do
      requires :id, type: String, desc: 'Book ID.'
      requires :title, type: String, desc: 'Title of a book.'
      requires :description, type: String, desc: 'Description of a book.'
      requires :page_count, type: Integer, desc: 'Page count of a book.'
    end
    put ':id' do
      Book.find(params[:id]).update({
                                    title: params[:title],
                                    description: params[:description],
                                    page_count: params[:page_count]
                             })
    end

    desc 'Delete a book.'
    params do
      requires :id, type: String, desc: 'Book ID.'
    end
    delete ':id' do
      Book.find(params[:id]).destroy
    end
  end
end
