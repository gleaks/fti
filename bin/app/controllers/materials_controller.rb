class MaterialsController < ApplicationController
    def index
    
        # Fetch every order from the database
        orders = Order.all.order(date: :desc)
        # Fetch all active assemblies
        @headers = Assembly.where(active: true).order(order: :asc)
        
        # Start an empty array of all of the orders that will be filled when we are done with iterating over each order
        @orders = []
        # Iterate over each order to extract information from it and reformat into an array for the view table
        orders.each do |order|
            # Begin an array for the order with the name of the order as the first item
            thisorder = {'name' => order.name, 'assemblies' => {}}
            # Iterate over each product added to an order
            order.order_boms.each do |order_bom|
                # Each product contains assemblies. Iterate over each assembly
                order_bom.product.product_boms.each do |product_bom|
                    # Multiply the amount of assemblies required for a product by the number of products added to the order
                    total = order_bom.count * product_bom.count
                    # Add a new key/value pair to the assemblies hash inside the thisorder hash with the assembly_id as the key and the total count as the value
                    thisorder['assemblies'][product_bom.assembly_id] = total
                end
            end
            # Add the completed hash of information about this order to the array of all orders
            @orders << thisorder
        end
    
        # Group everything in the module log by assembly & category, summing up the total in each group
        modules = Modulelog.select('assembly_id, category_id, count(id) as total').order(category_id: :asc).group('assembly_id', 'category_id')
        # Start an empty hash for all the modulelog data to be filled in by iterations
        @modules = {}
        
        # Query all the modulelogs categories
        @categories = Category.where(table: 'modulelogs').order(order: :asc)
        @categories.each do |category|
            # Iterate over every category and create a hash for it
            @modules[category.id] = {'name' => category.name, 'visible' => category.visible, 'color' => category.color}
        end
        
        modules.each do |m|
            # Iterate over all the modules we grouped together earlier & place in their appropriate hash with a new key/value of the assembly and how many there are
            @modules[m.category_id][m.assembly_id] = m.total
        end
    end
end
