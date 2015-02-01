class OcrUploadsController < ApplicationController

  # def uploadFile
  #   post = DataFile.save(params[:upload])
  #   render :text => "File has been uploaded successfully"
  # end

  def import
    begin
		@ocr_messages = OcrDatafile.import(params[:file])
		puts "redirect OK"
		render 'upload_results'
	rescue Exception => e
		puts "Error parsing OCR file. Exception:"
	  	puts e.inspect
	  	@ocr_messages = ['Error parsing OCR file!']
		render 'upload_results'
	end

  end

  # def upload_file
  #   post = OcrDatafile.save(params[:upload])
  #   render :text => "File has been uploaded successfully"
  # end

end
