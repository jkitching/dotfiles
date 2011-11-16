require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  # category/dirname/filename
  dotfiles = Dir['*/**/*'].map {|file| Dotfile.new file}
  dotfiles.each do |file|
    next if File.stat(file.src).directory?
    filetype = begin File.ftype file.dest rescue 'nonexistent' end

    # The file is either a regular file or a valid symbolic link.
    if File.exist?(file.dest) && ['file', 'link'].include?(filetype)
      if File.realpath(file.src) == File.realpath(file.dest)
        puts "symbolic link already exists on #{file.pretty_dest}"
      elsif file.identical?
        puts "identical #{file.pretty_dest}"
      elsif replace_all
        file.replace
      else
        print "overwrite #{file.pretty_dest}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          file.replace
        when 'y'
          file.replace
        when 'q'
          exit
        else
          puts "skipping #{file.pretty_dest}"
        end
      end

    # The file does exist, but is either an invalid symbolic link
    # or of an unexpected type.
    elsif filetype != 'nonexistent'
      puts "unexpected filetype of #{file.pretty_dest}: skipping"

    # The file does not exist.
    else
      file.link
    end
  end
end


class Dotfile
  attr_accessor :src, :category, :dest, :pretty_dest, :dest_dir, :short_src
  def initialize file
    @src = File.join(ENV['PWD'], file)
    parts = file.split '/'
    @category = parts.shift
    real_file = '.' + parts.join('/').sub('.erb', '')
    @dest = File.join(ENV['HOME'], real_file)
    @pretty_dest = File.join('~', real_file)
    @dest_dir = File.dirname @dest
  end

  def identical?
    File.identical?(@src, @dest) ||
      erb? && erb_result == File.read(@dest)
  end

  def erb?
    @src =~ /\.erb$/
  end

  def erb_result
    hostname = `hostname`.chop
    @erb_result ||= ERB.new(File.read(@src)).result(binding)
  end

  def replace
    system %Q{rm -fr "#{dest}"}
    link
  end

  def link
    if ENV['HOME'] != dest_dir
      system %Q{mkdir -p #{dest_dir}}
    end
    if erb?
      puts "generating #{pretty_dest}"
      File.open(dest, 'w') do |new_file|
        new_file.write erb_result
      end
    else
      puts "linking #{pretty_dest}"
      system %Q{ln -s "#{src}" "#{dest}"}
    end
  end
end
