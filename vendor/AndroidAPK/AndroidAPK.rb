# Class: AndroidAPK
#
# Open the APK file and parse the AndroidManifest.XML file
#

require 'AndroidAPK/AndroidBinaryXML'

class AndroidAPK #< ApplicationController

	def AndroidAPK.getAndroidManifestFromAPK(apkFile)
		apk = AndroidAPK.new
		apk.getAndroidManifestFromAPK(apkFile)
		return apk
	end
	
	def initialize
	  @tagHash = {}
	end
  
  def applicationAttrValue(attrName)
		children = @tagHash['children']
		children.each do |child|
			if child['name'] == "application"
				attrs = child['attrs']
				attrs.each do |attr|
					if attr['name'] == attrName
						return attr['value']
					end
				end
			end
		end
		return nil
  end

  def attrValue(attrs, attrName)
		attrs.each do |attr|
			if attr['name'] == attrName
				return attr['value']
			end
		end
		return nil
  end
	
  def applicationIcon
		return applicationAttrValue('icon')
  end

  def applicationLabel
		return applicationAttrValue('label')
  end

	def applicationName
		return applicationAttrValue('name')
	end
  
  def package
		return attrValue(@tagHash['attrs'], "package")
  end
  
  def tagHash
		@tagHash
  end

  def installLocation
		return attrValue(@tagHash['attrs'], "installLocation")
  end

  def versionCode
		return attrValue(@tagHash['attrs'], "versionCode")
  end
  
  def versionName
		return attrValue(@tagHash['attrs'], "versionName")
  end
	
	def getAndroidManifestFromAPK(apkFile)
		@tagHash = nil
		apkFile = File.expand_path(apkFile)
	
		puts "getAndroidManifestFromAPK: open " + apkFile
		if File.exist?(apkFile)
			
			begin
				Zip::ZipFile.open(apkFile) do |zipfile|
					puts "getAndroidManifestFromAPK:3: " + zipfile.name
					entry = zipfile.find_entry('AndroidManifest.xml')
					puts "getAndroidManifestFromAPK: entry " + entry.name
					

					# Create a new filename for the extracted AndroidManifest.xml file
          file_path = File.join(File.dirname(apkFile), entry.name)
          
          # If the extracted file exists then remove it
          if File.exists?(file_path)
						FileUtils.rm(file_path)
          end
          
          # Extract the AndroidManifest.xml file
          zipfile.extract(entry, file_path)

					puts "getAndroidManifestFromAPK: file_path #{file_path}"
						
					manifest = AndroidBinaryXML.open(file_path)
					@tagHash = manifest.unpackXML
					manifest.close
					
					puts "getAndroidManifestFromAPK:5"
				end		# do |zipfile|
				
#			rescue Zip::ZipDestinationFileExistsError => ex
#				logger.debug "getAndroidManifestFromAPK: File Does Not Exist: " + ex
		
#			rescue  => ex
#				logger.debug "getAndroidManifestFromAPK: Exception: #{ex}"
			end
		else
		end
		
		return
	end
  
end