# frozen_string_literal: true

require 'cancan'

module Spree
  module PermissionSets
    module Supplier
      class AdminAbility < PermissionSets::Base

        def activate!
          can %i[admin update read display stock],
            Spree::Product,
            suppliers: { id: user.supplier_id }
          
          can %i[admin create],
              Spree::Product
          
          can %i[admin create update destroy display],
              Spree::Variant

          can %i[admin display index update edit],
              Spree::Shipment,
              order: { state: 'complete' },
              stock_location: { supplier_id: user.supplier_id }

          can %i[admin display],
              Spree::ReturnAuthorization,
              stock_location: { supplier_id: user.supplier_id }

          can %i[admin display],
              Spree::CustomerReturn,
              stock_location: { supplier_id: user.supplier_id }

          can %i[admin index create edit read update],
              Spree::StockItem,
              stock_location: { supplier_id: user.supplier_id }

          cannot :display,
              Spree::StockLocation,
              active: true

          can %i[admin manage create],
              Spree::StockLocation,
              supplier_id: user.supplier_id,
              active: true

          can %i[admin manage create],
              Spree::StockMovement,
              stock_item: {
                stock_location: {
                  supplier_id: user.supplier_id
                }
              }

          can %i[admin create read update display],
              Spree::Supplier,
              id: user.supplier_id

          cannot %i[create index],
              Spree::Supplier

          can %i[display admin sales_total],
              :reports

          can %i[admin index edit update cancel show cart resend fire approve],
              Spree::Order,
              stock_locations: { supplier_id: user.supplier_id }

          can %i[admin manage create],
              Spree::Image

          if defined?(Spree::SalePrice)
            can %i[admin manage create update],
                Spree::SalePrice
          end
        end
      end
    end
  end
end
