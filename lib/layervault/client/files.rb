require 'multi_json'
require 'digest/md5'
require 'uri'

module LayerVault
  class Client
    module Files
      def file(organization_name, project_name, path, file_name)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}"
      end

      def delete_file(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the md5 option of the file you are trying to delete.") unless options.fetch(:md5, nil)
        delete "#{organization_name}/#{project_name}/#{path}/#{file_name}", options
      end

      def create_file(organization_name, project_name, path, file_name, options={} )
        raise ClientParamsError.new("You must specify the local_file_path option to the file you want to upload.") unless options.fetch(:local_file_path, nil)
        raise ClientParamsError.new("You must specify the content_type option to the content type of the file you are uploading.") unless options.fetch(:content_type, nil)

        local_file_path = options.fetch(:local_file_path, nil)
        content_type    = options.fetch(:content_type, nil)

        md5 = Digest::MD5.hexdigest(::File.read(local_file_path))
        options = {md5: md5}

        json_response = put("#{organization_name}/#{project_name}/#{path}/#{file_name}", options)

        s3_response = MultiJson.decode(json_response)
        s3_response.merge!( "Content-Type" => content_type)

        payload = s3_response.merge({ file: Faraday::UploadIO.new(local_file_path, content_type) })

        conn = Faraday.new('https://omnivore-scratch.s3.amazonaws.com') do |f|
          f.request :multipart
          f.request :url_encoded
          f.adapter :net_http # This is what ended up making it work
        end

        response_from_s3 = conn.post('/', payload)
        redirect = response_from_s3[:location]

        # Add the access_token to the query
        uri = URI.parse(redirect)
        new_query_ar = URI.decode_www_form(uri.query) << ["access_token", LayerVault.client.access_token]
        uri.query = URI.encode_www_form(new_query_ar)

        re = conn.post( uri.to_s )
      end

      def move_file(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the new_folder option to specify the destination folder") unless options.fetch(:new_folder, nil)
        raise ClientParamsError.new("You must specify the new_filename option to specify the destination folder") unless options.fetch(:new_file_name, nil)

        post "#{organization_name}/#{project_name}/#{path}/#{file_name}/move", options
      end

      def sync_check(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the md5 option of the file you are trying to sync check.") unless options.fetch(:md5, nil)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/sync_check", options
      end

      def previews(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the :w (width) and :h (height) options for the previews.") unless options.fetch(:w, nil) && options.fetch(:h, nil)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/previews", options
      end

      def revisions(organization_name, project_name, path, file_name, options={})
        raise ClientParamsError.new("You must specify the :first_seen or :latest_seen option for the file.") if options.fetch(:first_seen, nil) && options.fetch(:latest_seen, nil)
        get "#{organization_name}/#{project_name}/#{path}/#{file_name}/revisions", options
      end
    end
  end
end