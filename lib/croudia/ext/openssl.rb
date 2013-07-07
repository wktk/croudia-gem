require 'openssl'

class OpenSSL::SSL::SSLSocket
  # As of writing, https://api.croudia.com returns a valid cert for 
  # "croudia.com", but not for "api.croudia.com".  When the original check
  # process fails with "api.croudia.com", recheck as "croudia.com" and catch
  # the error if it looks valid.
  alias_method :croudia_original_pcc, :post_connection_check

  def post_connection_check(hostname)
    croudia_original_pcc(hostname)
  rescue OpenSSL::SSL::SSLError => e
    if hostname == 'api.croudia.com'
      croudia_original_pcc('croudia.com')
    else
      raise e
    end
  end
end
