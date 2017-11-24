class FaqsController < ApplicationController
  def index
    @faqs = Faq.all
  end

  def show #unnecessary show page for possible future use (future proofing)
    @faq = Faq.find(params[:id])
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new
    @faq.answer = params[:faq][:answer]
    @faq.question = params[:faq][:question]

    if @faq.save
      flash[:notice] = "FAQ was saved."
      redirect_to faqs_path
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @faq = Faq.find(params[:id])
  end

  def update
    @faq = Faq.find(params[:id])
    @faq.answer = params[:faq][:answer]
    @faq.question = params[:faq][:question]

    if @faq.save
      flash[:notice] = "FAQ was updated."
      redirect_to faqs_path
    else
      flash.now[:alert] = "There was an error saving the question. Please try again."
      render :edit
    end
  end

  private
  def adminOrNaw?

  end

  def trapKingOrNaw?

  end
end
