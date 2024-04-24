module Shows
  class CreateService
    def initialize(params, imported_file)
      @params = params
      @imported_file = imported_file
    end

    def call
      show.save!
      return show
    end

    private
    attr_reader :params, :imported_file

    def show
      @show ||= find_or_create_show
    end

    def find_or_create_show
      Show.find_or_create_by(
        key: params["Cle spectacle"],
        name: params["Spectacle"],
        imported_file_id: @imported_file.id
      )
    end
  end
end
