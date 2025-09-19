# frozen_string_literal: true

class LandingController < ApplicationController
  def index
  @testimonials = [
      {
        image_url: "https://img.daisyui.com/images/stock/photo-1625726411847-8cbb60cc71e6.webp",
        quote: "O Sistema de Estoque transformou a maneira como gerenciamos nossos produtos. A precisão e a facilidade de uso são incomparáveis. Nossa eficiência aumentou drasticamente!",
        name: "Maria Silva",
        role: "Gerente de Operações, Loja Essencial"
      },
      {
        image_url: "https://img.daisyui.com/images/stock/photo-1609621838510-5ad474b7d25d.webp",
        quote: "Acompanhar o estoque em tempo real facilitou muito nosso dia a dia. Recomendo para qualquer empresa!",
        name: "João Souza",
        role: "Supervisor, Supermercado Central"
      },
      {
        image_url: "https://img.daisyui.com/images/stock/photo-1414694762283-acccc27bca85.webp",
        quote: "Relatórios detalhados e interface intuitiva. O suporte também é excelente!",
        name: "Ana Paula",
        role: "Proprietária, Papelaria Criativa"
      },
      {
        image_url: "https://img.daisyui.com/images/stock/photo-1665553365602-b2fb8e5d1707.webp",
        quote: "A integração com fornecedores agilizou nossos pedidos. Muito satisfeito!",
        name: "Carlos Lima",
        role: "Compras, Loja de Ferragens"
      }
    ]
  end
end
