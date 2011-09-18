require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  # category/dirname/filename
  dotfiles = Dir['*/**/*'].map {|file| Dotfile.new file}
  dotfiles.each do |file|
    if File.stat(file.src).directory?
      next
    end
    if File.exist? file.dest
      if File.realpath(file.src) == File.realpath(file.dest)
        puts "symbolic link already exists on #{file.pretty_dest}"
      elsif File.identical? file.src, file.dest
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

  def erb?
    @src =~ /\.erb$/
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
      File.open(dest) do |new_file|
        new_file.write ERB.new(File.read(file)).result(binding)
      end
    else
      puts "linking #{pretty_dest}"
      system %Q{ln -s "#{src}" "#{dest}"}
    end
  end
end
