class CareersController < ApplicationController
  def index
    @jobs = Job.all.page params[:page]
  end

  def create
    @resume = Resume.create(resume_params)
    respond_to do |format|
      if @resume.save
        format.html { redirect_to careers_index_path, notice: 'Post was successfully created.' }
      else
        format.html { render action: "index" }
      end
    end
  end
end

private

def resume_params
  params.require(:resume).permit(:job_id, :name, :email, :phone, :description, upload_files_attributes: [:filename, :id])
end