class SubmissionsController < ApplicationController
  include Publisher
  include Receiver
  require 'bunny'
  require 'pry'
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  def index
    @submissions = Submission.all
  end

  def show
  end

  def new
    @submission = Submission.new
  end

  def edit
  end

  # POST /submissions
  def create
    #create new submission 
    @submission = Submission.new(submission_params)
    respond_to do |format|
      if @submission.save 
          publish(@submission)
          #calls the publish method which is inside the publisher.rb (a module to send the data to the queue)
          format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
          #so user knows submission was made (also for mild debugging)
          format.json { render :show, status: :created, location: @submission }
          start_receiver_connection
        #calls method in the publisher.rb 
      else
          format.html { render :new }
          format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      #the pieces of the submission object we want to capture and pass along! 
      params.require(:submission).permit(:name, :email,  :phone)
    end
end
