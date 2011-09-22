module BillsHelper
#  def next_barcode
#    (Bill.order('barcode DESC').first.try(:barcode) || 0) + 1
#  end
  
  def bill_for_select
   a = ['A','B','C','D']
   return a
  end
end
