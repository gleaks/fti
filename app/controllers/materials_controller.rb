class MaterialsController < ApplicationController
    def index
        orders = Order.all
        @modules = ["", "DC 9", "HP 6", "HP 200A", "HV 8", "Nan 7", "Nan B", "DVSD", "SCM", "SOA"]
        @orders = []
        
        orders.each do |order|
            thisorder = [order.name]
            dc9, hp6, hp200a, hv8, nan7, nanb, dvsd, scm, soa = 0, 0, 0, 0, 0, 0, 0, 0, 0
            order.order_boms.each do |order_bom|
                order_bom.product.product_boms.each do |product_bom|
                    total = order_bom.count * product_bom.count
                    
                    case product_bom.assembly.name
                    when "DC 9"
                        dc9 = total
                    when "HP 6"
                        hp6 = total
                    when "HV 8"
                        hv8 = total
                    when "Nano 7"
                        nan7 = total
                    when "DVSD 4"
                        dvsd = total
                    when "SCM 2"
                        scm = total
                    when "SOA CPU 1"
                        soa = total
                    end
                end
            end
            thisorder += [dc9, hp6, hp200a, hv8, nan7, nanb, dvsd, scm, soa]
            @orders << thisorder
        end
    end
end
