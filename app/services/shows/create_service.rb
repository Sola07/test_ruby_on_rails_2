module Shows
  class CreateService
    def initialize(params, imported_file_id)
      @params = params
      @imported_file_id = imported_file_id
    end

    def call
      show.save!
      return show
    end

    private
    attr_reader :params, :imported_file_id

    def show
      @show ||= find_or_create_show
    end

    def find_or_create_show
      show = ::Show.find_or_initialize_by(key: params["Cle spectacle"], imported_file_id: imported_file_id) do |new_show|
        new_show.key = params["Cle spectacle"]
        new_show.name = params["Spectacle"]
        new_show.imported_file_id = imported_file_id
      end
    end
  end
end
