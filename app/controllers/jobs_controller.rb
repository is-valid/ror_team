class JobsController < ApplicationController

  before_filter :last_posts_and_jobs , :only => [:index, :show]

  def index
    @resume = Resume.new
    @resume.upload_file = UploadFile.new
    @jobs = Job.includes(:upload_file).order('created_at DESC').page(params[:page]).per(3)
    @all_jobs_for_select = Job.select(:id, :title)
  end

  def show
    @job = Job.find(params[:id])
    @resume = Resume.new
    @resume.upload_file = UploadFile.new
  end

  def create
    @resume = Resume.new(resume_params)
    unless @resume.job_id.blank?
      @job = Job.find(@resume.job_id)
      if @resume.save
        redirect_to jobs_path, :notice => 'Your resume is successfully sent.'
      else
        @resume.upload_file = UploadFile.new
        render 'show'
      end
    else
      @resume.upload_file = UploadFile.new
      redirect_to jobs_path, :error => 'Sorry. No jobs found'
    end
  end

private

  def resume_params
    params.require(:resume).permit(:job_id, :name, :email, :phone, :description, upload_file_attributes: [:filename, :id])
  end

end