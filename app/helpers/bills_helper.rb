module BillsHelper
#  def next_barcode
#    (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
#  end
  
  def bill_for_select
   ['A','B','C','D']
   end
end
