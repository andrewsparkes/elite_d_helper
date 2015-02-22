class OcrUploadsController < ApplicationController

  def import
    begin
		  @ocr_messages, @station = OcrDatafile.import(params[:file])
		  render 'upload_results'
	  rescue Exception => e
		  puts "Error parsing OCR file. Exception:"
	  	puts e.inspect
	  	@ocr_messages = ['Error parsing OCR file!']
		  render 'upload_results'
    end
  end
end
