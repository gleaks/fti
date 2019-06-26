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
        
        tested_dc9 = Modulelog.where(category_id: 49, assembly_id: 21).count
        tested_hp6 = Modulelog.where(category_id: 49, assembly_id: 30).count
        tested_hp200a = 0
        tested_hv8 = Modulelog.where(category_id: 49, assembly_id: 32).count
        tested_nan7 = Modulelog.where(category_id: 49, assembly_id: 43).count
        tested_nanb = 0
        tested_dvsd = Modulelog.where(category_id: 49, assembly_id: 26).count
        tested_scm = Modulelog.where(category_id: 49, assembly_id: 55).count
        tested_soa = Modulelog.where(category_id: 49, assembly_id: 56).count
        
        @tested = [tested_dc9, tested_hp6, tested_hp200a, tested_hv8, tested_nan7, tested_nanb, tested_dvsd, tested_scm, tested_soa]
    end
end
