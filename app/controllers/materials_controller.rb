class MaterialsController < ApplicationController
    def index
    
        # Fetch every order from the database
        orders = Order.all
        
        # Create an ordered array for the column titles of the view table
        @modules = ["", "DC 9", "HP 6", "HP 200A", "HV 8", "Nan 7", "Nan B", "DVSD", "SCM", "SOA", "AC 10", "AC 11", "CC", "PG", "Rg 2.100", "RG 3.0", "Digi 7", "TMU", "IC", "QVI", "DIG 2"]
        # Start an empty array of all of the orders that will be filled when we are done with iterating over each order
        @orders = []
        
        
        # Iterate over each order to extract information from it and reformat into an array for the view table
        orders.each do |order|
            # Begin an array for the order with the name of the order as the first item
            thisorder = [order.name]
            
            # Set all the default values for each module to 0
            dc9, hp6, hp200a, hv8, nan7, nanb, dvsd, scm, soa, ac10, ac11, cc = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
            
            # Iterate over each product added to an order
            order.order_boms.each do |order_bom|
                # Each product contains assemblies. Iterate over each assembly
                order_bom.product.product_boms.each do |product_bom|
                    # Multiply the amount of assemblies required for a product by the number of products added to the order
                    total = order_bom.count * product_bom.count
                    
                    # Look at the name of an assembly and place the previously calculated number of assemblies required into the correct assembly
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
                    when "Cap Charger 4.9"
                        cc = total
                    end
                end
            end
            # Add the calculated totals for each assembly in the correct display order into our previously created thisorder array
            thisorder += [dc9, hp6, hp200a, hv8, nan7, nanb, dvsd, scm, soa, ac10, ac11, cc]
            # Add the completed array of information to this order to the array of all orders
            @orders << thisorder
        end
        
        # Count all of the Tested modules from the Module Log & place them into an array for the display table
        t_dc9 = Modulelog.where(category_id: 49, assembly_id: 21).count
        t_hp6 = Modulelog.where(category_id: 49, assembly_id: 30).count
        t_hp200a = 0
        t_hv8 = Modulelog.where(category_id: 49, assembly_id: 32).count
        t_nan7 = Modulelog.where(category_id: 49, assembly_id: 43).count
        t_nanb = 0
        t_dvsd = Modulelog.where(category_id: 49, assembly_id: 26).count
        t_scm = Modulelog.where(category_id: 49, assembly_id: 55).count
        t_soa = Modulelog.where(category_id: 49, assembly_id: 56).count
        t_ac10 = 0
        t_ac11 = 0
        t_cc = Modulelog.where(category_id: 49, assembly_id: 17).count
        @tested = [t_dc9, t_hp6, t_hp200a, t_hv8, t_nan7, t_nanb, t_dvsd, t_scm, t_soa, t_ac10, t_ac11, t_cc]
        
        # Count all of the modules in bring-up from the module log & place in an array for the display table
        bu_dc9 = Modulelog.where(category_id: 54, assembly_id: 21).count
        bu_hp6 = Modulelog.where(category_id: 54, assembly_id: 30).count
        bu_hp200a = 0
        bu_hv8 = Modulelog.where(category_id: 54, assembly_id: 32).count
        bu_nan7 = Modulelog.where(category_id: 54, assembly_id: 43).count
        bu_nanb = 0
        bu_dvsd = Modulelog.where(category_id: 54, assembly_id: 26).count
        bu_scm = Modulelog.where(category_id: 54, assembly_id: 55).count
        bu_soa = Modulelog.where(category_id: 54, assembly_id: 56).count
        bu_ac10 = 0
        bu_ac11 = 0
        bu_cc = Modulelog.where(category_id: 54, assembly_id: 17).count
        @bringup = [bu_dc9, bu_hp6, bu_hp200a, bu_hv8, bu_nan7, bu_nanb, bu_dvsd, bu_scm, bu_soa, bu_ac10, bu_ac11, bu_cc]
    end
end
