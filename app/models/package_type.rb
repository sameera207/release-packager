class PackageType
  attr_accessor :id, :name
  
  #loading default package types
  def self.load_package_types
    types = []
    
    %w{zip tag.gz}.each do |t|
      type = PackageType.new
      type.id = type.name = t
      types << type
    end
    types
  end
  
end