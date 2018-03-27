require_relative '../hap/service'
require_relative '../hap/accessory'

module Rubyhome
  class AccessoryFactory
    def self.create(service_name, options={})
      if service_name == :accessory_information
        AccessoryInformationFactory.create(service_name, options)
      else
        new(service_name, options).create
      end
    end

    def initialize(service_name, options)
      @service_name = service_name
      @options = options
    end

    def create
      yield find_service if block_given?


      accessory_information_params = options.merge(accessory: find_service.accessory)

      AccessoryInformationFactory.create(service_name, accessory_information_params)
      find_service.save
      find_service
    end

    private

      attr_reader :service_name, :options

      def find_service
        @service ||= Service.descendants.find do |service|
          service.name == service_name
        end.new(service_params)
      end

      def service_params
        options[:accessory] ||= Rubyhome::Accessory.new
        options
      end
  end
end
