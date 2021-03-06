require "pty"
module Mccloud
	module Util
		def self.rsync(path,vm,instance)
			command="rsync --delete -avz -e 'ssh -p 22 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -i \"#{vm.private_key}\"' '#{path}/' '#{vm.user}@#{instance.public_ip_address}:/tmp/#{File.basename(path)}/'"
			puts command
    begin
      PTY.spawn( command ) do |r, w, pid|
        begin
          r.each { |line| print line;}
       rescue Errno::EIO
       end
     end
   rescue PTY::ChildExited => e
      puts "The child process exited!"
			   end
			#Kernel.exec(command)
		end
	end
end

