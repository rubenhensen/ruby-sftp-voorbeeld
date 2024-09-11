require 'net/sftp'
require 'uri'

class SFTPClient
  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
  end

  def connect
    sftp_client.connect!
  rescue Net::SSH::RuntimeError
    puts "Failed to connect to #{@host}"
  end

  def disconnect
    sftp_client.close_channel
    ssh_session.close
  end

  def upload_file(local_path, remote_path)
    @sftp_client.upload!(local_path, remote_path)
    puts "Uploaded #{local_path}"
  end

  def download_file(remote_path, local_path)
    @sftp_client.download!(remote_path, local_path)
    puts "Downloaded #{remote_path}"
  end

  def list_files(remote_path)
    @sftp_client.dir.foreach(remote_path) do |entry|
      puts entry.longname
    end
  end

  def sftp_client
    @sftp_client ||= Net::SFTP::Session.new(ssh_session)
  end

  private

  def ssh_session
    @ssh_session ||= Net::SSH.start(@host, @user, @password)
  end
end

sftptogo_url = ENV['SFTPTOGO_URL']
# puts sftptogo_url

begin
  uri = URI.parse(sftptogo_url)
rescue URI::InvalidURIError
  puts 'Bad SFTPTOGO_URL'
end

# puts uri.password
sftp = SFTPClient.new(uri.host, uri.user, password: uri.password)
sftp.connect

# list files in directory
sftp.list_files('/foys')

# upload files
sftp.upload_file('./test.txt', '/foys/test.txt')

# list files in directory
sftp.list_files('/foys')

# download files
sftp.download_file('/foys/test.txt', './downloaded_text.txt')

# disconnect
sftp.disconnect