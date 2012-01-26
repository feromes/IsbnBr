#encoding: UTF-8

require "./lib/isbn_br"

describe IsbnBr do
  context "dado um número ISBN válido de 13 dígitos de um livro existente" do
    livro_procurado = IsbnBr.new("9788563876119")
    it "deve devolver o título do livro" do
      livro_procurado.titulo.should == "Pequena história das grandes ideias: como a filosofia inventou nosso mundo"
    end
  end
  context "dado um número de ISBN válido porém não localizado" do
    livro_procurado = IsbnBr.new("1234567890123")
    it "deve devolver o mesmo número de ISBN" do
      livro_procurado.isbn.should == "1234567890123"
    end
    it "deve devolver uma mensagem de ISBN não encontrado" do
      livro_procurado.titulo.should == nil
      pending
    end
  end 
end
