#encoding: UTF-8  

require 'rubygems'
require 'mechanize'

class IsbnBr
  attr_accessor :titulo, :isbn, :autor, :page

  def initialize(isbn)
    self.isbn = isbn
    scrap_it
  end
      
  def titulo
    to_hash["TÍTULO"]
  end
  
  def autor
    to_hash["AUTOR"]
  end
  
  def scrap_it
    agent = Mechanize.new
    page = agent.get 'http://www.bn.br/site/pages/servicosProfissionais/agenciaISBN/isbnBusca/FbnBuscaISBNCatalogo.asp?pField=ISBN&pIntPagina=1'
    
    form = page.forms.last
    form.pISBN = isbn[5..12]
    form.pCDIDT = '978-85-'
    form.radiobuttons.first.value = "isbn_13"
    
    self.page = agent.submit form 
  end
  
  def to_hash
    keys = page.search('tr/td/p/span.AgendaItensBold').map {|a| a.children.text.gsub(":", "").chop }
    values = page.search('tr/td/p/span.BarLatPubl').map {|a| a.children.text}
    Hash[*keys.zip(values).flatten]
  end
end
