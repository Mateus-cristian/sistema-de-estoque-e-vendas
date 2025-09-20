# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sale, only: %i[show destroy]

  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    respond_to do |format|
      if @sale.save
        flash.now[:notice] = I18n.t("sales.created")
        format.html { redirect_to sales_path, notice: I18n.t("sales.created") }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("toast", partial: "shared/toast", locals: { notice: I18n.t("sales.created"), alert: nil }),
            turbo_stream.replace("sale_form", partial: "sales/form", locals: { sale: Sale.new })
          ]
        end
      else
        translated_errors = @sale.errors.map do |attr, msg|
          attr_name = Sale.human_attribute_name(attr)
          if msg.present?
            msg = msg.gsub(attr.to_s.humanize, attr_name) if msg.is_a?(String)
            msg.include?(attr_name) ? msg : "#{attr_name} #{msg}"
          end
        end.compact.uniq.join(", ")
        flash.now[:alert] = I18n.t("sales.error", errors: translated_errors)
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("toast", partial: "shared/toast", locals: { notice: nil, alert: I18n.t("sales.error", errors: @sale.errors.full_messages.to_sentence) }),
            turbo_stream.replace("sale_form", partial: "sales/form", locals: { sale: @sale })
          ]
        end
      end
    end
  end

  def show
    authorize @sale
  end

  def destroy
    authorize @sale
    @sale.destroy
    respond_to do |format|
  format.html { redirect_to sales_path, notice: I18n.t("sales.removed") }
      format.turbo_stream
    end
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end

  private

  def sale_params
    params.require(:sale).permit(:product_id, :quantity)
  end
end
